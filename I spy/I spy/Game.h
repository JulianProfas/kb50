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
@property (nonatomic, strong) NSMutableSet *answers;
@property int round;
@property int time;
@property int guessCounter;

#pragma mark - Game Singleton Methods
/**
    Returns the current gamclass if one is allocated if not one will be created
 
 @return the game class
 */
+ (Game*)sharedManager;
/**
 
 @param
 @return
 */
+ (id)allocWithZone:(NSZone *)zone;
/**
 
 @param
 @return
 */
- (id)copyWithZone:(NSZone *)zone;

#pragma mark - Game Class Methods
/**
 Setups the game
 
 */
-(void)setupGame;
/**
    Set the answer label to the choosen color

 */
-(void)setAnswerLabel;
/**
     Checks the given answer
 @param the given point(x,y)
 @return Yes for correct answer, No for incorrect answer
 */
-(BOOL)checkAnswer: (CGPoint)guess;
/**
 Starts the timer to start the game
 
 */
-(void)startGame;
/**
 Stops the timer.
 
 */
-(void)roundOver;
/**
    start the take picture process
 @return a taken picture
 */
-(Photo *)takePicture;

#pragma mark - Score related Methods
/**
    Updates the score when correct answer
 */
-(void)updateScore;
/**
    Gives a score by difficulty when hard less points than when easy
 @return int
            scores
 */
-(int)getScoreByDifficulty;

@end
