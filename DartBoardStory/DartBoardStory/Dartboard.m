//
//  Dartboard.m
//  DartBoardStory
//
//  Created by HHs on 9/21/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Dartboard.h"
#import "Score.h"

static NSUInteger dificulty = 0;

@implementation Dartboard

@synthesize dartboardViewController;

-(id) initWithDartboardViewController:(DartboardViewController *)viewController centerYPosition:(int)centerYPosition centerXPosition:(int)centerXPosition
{
    self = [super init];
    if (self) {
        self.dartboardViewController = viewController;
        score = [[Score alloc] init];
        dificulty = 0;
        dartboardCenterXPosition = centerXPosition;
        dartboardCenterYPosition = centerYPosition;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        dificulty = (int)[prefs integerForKey:@"dificulty"];
    }
    return self;
}

-(int) getRandomDartCoordinate
{
    int randomCoordinate = 0;
    if(dificulty == 0){
        randomCoordinate = -3 + arc4random() % (3 - -3);
    }else if(dificulty == 1){
        randomCoordinate = -10 + arc4random() % (10 - -10);
    }else if(dificulty == 2){
        randomCoordinate = -30 + arc4random() % (30 - -30);
    }
    
    return randomCoordinate;
}

-(int)getScoreXPosition:(int)dartXposition dartYPostion:(int)dartYPosition
{
    return [score getScoreDartXPosition:dartXposition dartYPostion:dartYPosition centerX:dartboardCenterXPosition     centerY:dartboardCenterYPosition];
}

+ (NSUInteger) getDificulty {
    return dificulty;
}

+ (void) setDificulty:(NSUInteger)dificultyNumber
{
    dificulty = dificultyNumber;
}

@end
