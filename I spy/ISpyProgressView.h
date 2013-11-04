//
//  ISpyProgressView.h
//  TimerProject
//
//  Created by iOS Team on 10/15/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

typedef enum {
    UILabelLeft,
    UILabelRight
} UILabelPosition;

@interface ISpyProgressView : UIProgressView
{
    NSTimeInterval initialTime;
    NSTimer *timer;
    UILabel *timerLabel;
    bool adding;
    bool labelTimerActive;
}
@property (nonatomic) NSTimeInterval time;
@property (nonatomic, assign) UILabelPosition labelPosition;

/**
 Initializes the timerlabel with a position
 @param label
 Determines if the label should show or not.
 @param _labelPosition
 The position of the timerlabel.
 @param _frame
 The frame the timerlabel is in
 
 @return
 */
-(id) initWithTimerLabel:(bool)label LabelPosition:(UILabelPosition)_labelPosition Frame:(CGRect *)_frame;
/**
 Starts the timer
 */
-(void) startTimer;
/**
 Stops the timer
 */
-(void) stopTimer;
/**
 Sets the timer to the initial value
 */
-(void) resetTimer;
/**
 Sets the timer to a given value.
 @param setTime
 The time, which the timer should be set to.
 */
-(void) setTime:(NSTimeInterval)setTime;
/**
 Increases the timer with a given value.
 @param addTime
 The time that should be added to the timer.
 */
-(void) addTime:(float) addTime;
/**
 Decreases the timer with a given value.
 @param decreaseTime
 The amount of time the timer should be decreased with.
 
 @return Returns a bool
 */
-(bool) decreaseTime:(float)decreaseTime;

@end
