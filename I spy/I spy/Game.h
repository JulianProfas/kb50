//
//  Game.h
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Game : NSObject
{
    int numberOfAttempts;
    Player *currentPlayer;
}

@property (nonatomic, retain) Player *currentPlayer;

#pragma mark - Game Singleton Methods
+ (Game*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

#pragma mark - Game Class Methods
-(void)highlightAnswer;
-(void)checkAnswer: (CGPoint)guess;
-(void)displayWinAlert;
-(void)updateStatus;
-(void)startGame;
-(void)endGame;
-(void)nextRound;
-(void)updateScore;
@end
