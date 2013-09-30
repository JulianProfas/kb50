//
//  Score.h
//  DartBoardStory
//
//  Created by HHs on 9/21/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject
{
    NSDictionary *boardLeftTop;
    NSDictionary *boardLeftBottom;
    NSDictionary *boardRightTop;
    NSDictionary *boardRightBottom;
}
-(id)init;
-(int)getScoreDartXPosition:(int)dartXposition dartYPostion:(int)dartYPosition centerX:(int)centerX centerY:(int)centerY;
-(NSDictionary *)getScoreBoardDartYPos:(int)dartYPos dartXPos:(int)dartXPos centerYPos:(int)centerYPos centerXPos:(int)centerXPos;
-(int)calculateScoreDartboard:(NSDictionary *)dartboard hypotenuse:(float)hypotenuse angle:(float)angle;
@end
