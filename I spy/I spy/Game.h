//
//  Game.h
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Photo.h"
#import "ISpyProgressView.h"

@interface Game : NSObject
{
    int numberOfAttempts;
    int time;
    int round;
    int guessCounter;
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
@property int round;
@property int time;
@property int guessCounter;

#pragma mark - Game Singleton Methods
+ (Game*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

#pragma mark - Game Class Methods
-(void)setupGame;
-(void)setAnswerLabel;
-(BOOL)checkAnswer: (CGPoint)guess;
-(void)startGame;
-(void)roundOver;
-(Photo *)takePicture;

#pragma mark - Score related Methods
-(void)updateScore;
-(int)getScoreByDifficulty;

@end
