//
//  Game.h
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "ISpyProgressView.h"

@interface Game : NSObject
{
    int numberOfAttempts;
    Player *currentPlayer;
    ISpyProgressView *progressBar;
    UICountingLabel *scoreLabel;
    UIImage *capturedImage;
    UINavigationBar *navigationBar;
    bool gameRunning;
}

@property (nonatomic, retain) Player *currentPlayer;
@property (nonatomic, retain) Photo *currentPhoto;
@property (nonatomic, strong) ISpyProgressView *progressBar;
@property (nonatomic, strong) UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, retain) Photo *photo;
@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) NSMutableSet *answers;

#pragma mark - Game Singleton Methods
+ (Game*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

#pragma mark - Game Class Methods
-(void)setupGame;
-(void)setAnswerLabel;
-(void)highlightAnswer;
-(BOOL)checkAnswer: (CGPoint)guess;
-(void)displayWinAlert;
-(void)startGame;
-(void)gameOver;
-(void)nextRound;
-(Photo *)takePicture;
-(bool)isRunning;

#pragma mark - Score related Methods
-(void)updateScore;
-(int)getScoreByDifficulty;

@end
