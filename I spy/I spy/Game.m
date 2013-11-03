//
//  Game.m
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
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
@synthesize round;
@synthesize time;
@synthesize guessCounter;

#define GOOD_GUESS 30
#define BAD_GUESS 5

#pragma mark - Game Singleton Methods

static Game *sharedGameManager = nil;

+ (Game*)sharedManager
{
    if (sharedGameManager == nil)
    {
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

-(void)setupGame
{
    currentPhoto = [self takePicture];
}

-(void)setAnswerLabel
{
    answers = [currentPhoto answerSet];
    navigationBar.topItem.title = [NSString stringWithFormat:@"%@", [currentPhoto answerColor]];
}

- (BOOL) checkAnswer: (CGPoint)guess {
    if (![answers containsObject:[NSValue valueWithCGPoint:guess]])
    {
        NSLog(@"You've made a bad guess");
        guessCounter--;
    } else
    {
        //good guess
        NSLog(@"You've won!");
        
        [self updateScore];
        [progressBar addTime:GOOD_GUESS];
        return true;
    }
    return false;
}

-(void)startGame
{
    [progressBar setTime:10.0f];
    [progressBar resetTimer];
    [progressBar startTimer];
    guessCounter = 5;
}

-(void)roundOver
{
    [progressBar stopTimer];
}

-(Photo *)takePicture
{
    [spinner startAnimating];
    return [[Photo alloc]initWithImage:capturedImage difficulty:@"easy"];
}

#pragma mark - Score related Methods

-(void)updateScore
{
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
    int difficulty = 0;
    int score = 0;
    
    switch (difficulty) {
        case 0: //Easy
            score = 20*guessCounter;
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

@end
