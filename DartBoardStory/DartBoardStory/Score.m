//
//  Score.m
//  DartBoardStory
//
//  Created by HHs on 9/21/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Score.h"

@implementation Score

#define BOARD_HEIGHT 96
#define BULLSEYE 5
#define BULL 10

-(id)init{
    self = [super init];
    if (self) {
        boardLeftTop = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithFloat:20], [NSNumber numberWithFloat:9],
                    [NSNumber numberWithFloat:5], [NSNumber numberWithFloat:27],
                    [NSNumber numberWithFloat:12], [NSNumber numberWithFloat:45],
                    [NSNumber numberWithFloat:9], [NSNumber numberWithFloat:63],
                    [NSNumber numberWithFloat:14], [NSNumber numberWithFloat:81],
                    [NSNumber numberWithFloat:11], [NSNumber numberWithFloat:90],
                        nil];
        
        boardLeftBottom = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSNumber numberWithInt:3], [NSNumber numberWithFloat:9],
                        [NSNumber numberWithInt:19], [NSNumber numberWithFloat:27],
                        [NSNumber numberWithInt:7], [NSNumber numberWithFloat:45],
                        [NSNumber numberWithInt:16], [NSNumber numberWithFloat:63],
                        [NSNumber numberWithInt:8], [NSNumber numberWithFloat:81],
                        [NSNumber numberWithInt:11], [NSNumber numberWithFloat:90],
                        nil];
        
        boardRightTop = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:20], [NSNumber numberWithFloat:9],
                           [NSNumber numberWithInt:1], [NSNumber numberWithFloat:27],
                           [NSNumber numberWithInt:18], [NSNumber numberWithFloat:45],
                           [NSNumber numberWithInt:4], [NSNumber numberWithFloat:63],
                           [NSNumber numberWithInt:13], [NSNumber numberWithFloat:81],
                           [NSNumber numberWithInt:6], [NSNumber numberWithFloat:90],
                           nil];
        
        boardRightBottom = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:3], [NSNumber numberWithFloat:9],
                           [NSNumber numberWithInt:17], [NSNumber numberWithFloat:27],
                           [NSNumber numberWithInt:2], [NSNumber numberWithFloat:45],
                           [NSNumber numberWithInt:15], [NSNumber numberWithFloat:63],
                           [NSNumber numberWithInt:10], [NSNumber numberWithFloat:81],
                           [NSNumber numberWithInt:6], [NSNumber numberWithFloat:90],
                           nil];
        
    }
    
    return self;
}

-(int)getScoreDartXPosition:(int)dartXposition dartYPostion:(int)dartYPosition centerX:(int)centerX centerY:(int)centerY
{
    float lengthAB, lengthBC, hypotenuse, angle;
    
    lengthBC = abs(centerX -dartXposition);
    lengthAB = abs(centerY - dartYPosition);
    hypotenuse = sqrt((pow(lengthAB, 2) + pow(lengthBC, 2)));
    angle = atan((lengthBC / lengthAB)) *(180 / M_PI);
    
    NSLog(@"BC = %f AB = %f hypotenuse = %f angle = %f", lengthBC, lengthAB, hypotenuse, angle);
    
    int score = [self calculateScoreDartboard:[self getScoreBoardDartYPos:dartYPosition dartXPos:dartXposition centerYPos:centerY centerXPos:centerX] hypotenuse:hypotenuse angle:angle];
    
    return score;
}

-(NSDictionary *)getScoreBoardDartYPos:(int)dartYPos dartXPos:(int)dartXPos centerYPos:(int)centerYPos centerXPos:(int)centerXPos
{
    NSDictionary *temp;
    
    if((dartYPos <= centerYPos) && (dartXPos <= centerXPos)){
        temp = boardLeftTop;
    }else if((dartYPos >= centerYPos) && (dartXPos <= centerXPos)){
        temp = boardLeftBottom;
    }else if((dartYPos <= centerYPos) && (dartXPos >= centerXPos)){
        temp = boardRightTop;
    }else{
        temp = boardRightBottom;
    }
    
    return temp;
}

-(int)calculateScoreDartboard:(NSDictionary *)dartboard hypotenuse:(float)hypotenuse angle:(float)angle;
{
    int score;
    if(hypotenuse < BOARD_HEIGHT){
        if(hypotenuse < BULL){
            if(hypotenuse < BULLSEYE){
                score = 50;
            }else{
                score = 25;
            }
        }else{
            for(NSNumber *identifier in dartboard){
                int dartboardPiece = [identifier floatValue];
                
                if((angle >= (dartboardPiece - 18) && (angle <= dartboardPiece))){
                    int baseScore = [[dartboard objectForKey:identifier] integerValue];

                    if(hypotenuse >= 90){
                        score = baseScore * 2;
                    }else if((hypotenuse >= 53) && (hypotenuse <= 60)){
                        score = baseScore * 3;
                    }else{
                        score = baseScore;
                    }
                    
                    break;
                }
            }
        }
    }else{
        score = 0;
    }
    
    return score;
}
@end
