//
//  ISpyProgressView.h
//  TimerProject
//
//  Created by justin on 10/15/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"
typedef enum {
    UILabelLeft,
    UILabelRight
} UILabelPosition;

@interface ISpyProgressView : UIProgressView
{
    NSTimeInterval time;
    NSTimeInterval initialTime;
    NSTimer *timer;
    UILabel *timerLabel;
    bool adding;
    bool labelTimerActive;
}
@property (nonatomic) NSTimeInterval time;
@property (nonatomic, assign) UILabelPosition labelPosition;

- (id)initWithTimerLabel:(bool)label LabelPosition:(UILabelPosition)_labelPosition Frame:(CGRect *)_frame;
- (void)startTimer;
- (void)stopTimer;
- (void)resetTimer;
- (void)setTime:(NSTimeInterval)setTime;
- (void)addTime:(float) addTime;
- (bool)decreaseTime:(float)decreaseTime;
@end
