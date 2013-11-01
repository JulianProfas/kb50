//
//  Game.m
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Game.h"
#import "Player.h"
#import "ISpyProgressView.h"
#import "Photo.h"
#import "SinglePlayerViewController.h"

@implementation Game
@synthesize currentPlayer;
@synthesize currentPhoto;
@synthesize progressBar;
@synthesize scoreLabel;
@synthesize capturedImage;
@synthesize navigationBar;
@synthesize spinner;
@synthesize answers;

#define GOOD_GUESS 20
#define BAD_GUESS 5

#pragma mark - Game Singleton Methods

static Game *sharedGameManager = nil;

+ (Game*)sharedManager
{
    if (sharedGameManager == nil) {
        sharedGameManager = [[super allocWithZone:NULL] init];
    }
    return sharedGameManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Game Class Methods

-(void)setupGame {
    currentPhoto = [self takePicture];
    [self setupAnswers];
}

-(void)setAnswerLabel {
    navigationBar.topItem.title = [NSString stringWithFormat:@"%@", [currentPhoto answerColor]];
}

-(void)highlightAnswer {
}

- (void) setupAnswers {
    answers = [currentPhoto answerSet];
}

- (BOOL) checkAnswer: (CGPoint)guess {
    bool result;
    
    if (![answers containsObject:[NSValue valueWithCGPoint:guess]]) {
        //bad guess
        if([progressBar decreaseTime:BAD_GUESS]){
            //[self gameOver];
            //[self displayWinAlert];
            result = false;
        }else{
            [self gameOver];
            [self displayLoseAlert];
            result = true;        }
    } else {
        //good guess
        NSLog(@"You've won!");
        
        [self updateScore];
        [progressBar addTime:GOOD_GUESS];
        
        [self highlightAnswer];
        [self displayWinAlert];
        result = true;
    }
    
    return result;
}

-(void)displayWinAlert {
    [progressBar stopTimer];
    
    //display alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've won the game!"
                                                    message:@"You gained 20 seconds."
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Next round", @"Replay photo", nil];
    [alert show];
}

-(void)displayLoseAlert {
    [progressBar stopTimer];
    
    //display alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've lost the game"
                                                    message:@"Game over."
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)startGame {
    gameRunning = true;
    [progressBar setTime:30.0f];
    [progressBar resetTimer];
    [progressBar startTimer];
}

-(void)gameOver {
    gameRunning = false;
    [self highlightAnswer];
    [progressBar stopTimer];
}

-(void)nextRound {
    [progressBar stopTimer];
    [self setupGame];
    [self startGame];
}

-(Photo *)takePicture {
    [spinner startAnimating];
    
    return [[Photo alloc]initWithImage:capturedImage difficulty:@"easy"];
}

#pragma mark - Score related Methods

-(void)updateScore {
    int previousScore = [[Player sharedManager] score];
    [[Player sharedManager] setScore:previousScore + [self getScoreByDifficulty]];
    
    // count up using a string that uses a number formatter
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    scoreLabel.formatBlock = ^NSString* (float value)
    {
        NSString* formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"Score %@",formatted];
    };
    scoreLabel.method = UILabelCountingMethodEaseOut;
    [scoreLabel countFrom:previousScore to:[[Player sharedManager] score] withDuration:2];
    
    //[label setText:[NSString stringWithFormat:@"Score : %d",[player score]]];
}

-(int)getScoreByDifficulty
{
    int difficulty = 0; //ophalen uit settings class
    int score = 0;
    
    switch (difficulty) {
        case 0: //Easy
            score = 100;
            break;
        case 1: //Medium
            score = 75;
            break;
        case 2: //Hard
            score = 50;
            break;
        default:
            score = 100;
            break;
    }
    
    return score;
}

- (void) replayPhoto
{
    [self setupAnswers];
    [self setAnswerLabel];
    [self startGame];
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[theAlert buttonTitleAtIndex:buttonIndex] isEqualToString:@"Next round"]) {
        [self nextRound];
    } else if ([[theAlert buttonTitleAtIndex:buttonIndex] isEqualToString:@"Replay photo"])
    {
        [self replayPhoto];
    }
    //TODO: display correct color question again
    
    //NSLog(@"The %@ button was tapped.", [theAlert buttonTitleAtIndex:buttonIndex]);
}

-(bool)isRunning
{
    return gameRunning;
}

@end
