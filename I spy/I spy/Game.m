//
//  Game.m
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Game.h"
#import "Player.h"

@implementation Game
@synthesize currentPlayer;

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
-(void)highlightAnswer {
    //circle correct answer
    
    
}

-(void)checkAnswer: (CGPoint)guess {
    if (!CGPointEqualToPoint(guess,[[Player sharedManager] answer])) {
        NSLog(@"Guess again!");
    } else {
        NSLog(@"You've won!");
        [self displayWinAlert];
    }
}

-(void)displayWinAlert {
    //stop timer
    
    //display alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've won the game!"
                                                    message:@"You gained 10 seconds."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [self highlightAnswer];

}

-(void)updateStatus {
    //good guess
    
    //bad guess
}

-(void)startGame {
    [currentPlayer takePicture];
    
    //start timer
}

-(void)endGame {
    //stop timer
}

-(void)nextRound {
    
}

-(void)updateScore {
    
}

@end
