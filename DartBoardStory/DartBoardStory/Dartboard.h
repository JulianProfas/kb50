//
//  Dartboard.h
//  DartBoardStory
//
//  Created by HHs on 9/21/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DartboardViewController;
@class Score;

@interface Dartboard : NSObject
{
    DartboardViewController *dartboardViewController;
    Score *score;
    int dartboardCenterYPosition;
    int dartboardCenterXPosition;
}
@property (nonatomic, retain) DartboardViewController *dartboardViewController;
@property (nonatomic) int dartboardCenterYPosition;
@property (nonatomic) int dartboardCenterXPosition;

-(id)initWithDartboardViewController:(DartboardViewController *)viewController centerYPosition:(int)centerYPosition centerXPosition:(int)centerXPosition;
-(int)getRandomDartCoordinate;
-(int)getScoreXPosition:(int)dartXposition dartYPostion:(int)dartYPosition;
+ (NSUInteger) getDificulty;
+ (void) setDificulty:(NSUInteger)dificulty;

@end
