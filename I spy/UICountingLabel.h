//
//  UICountingLabel.h
//  TimerProject
//
//  Created by iOS Team on 10/17/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    UILabelCountingMethodEaseInOut,
    UILabelCountingMethodEaseIn,
    UILabelCountingMethodEaseOut,
    UILabelCountingMethodLinear
} UILabelCountingMethod;

typedef NSString* (^UICountingLabelFormatBlock)(float value);

@interface UICountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) UILabelCountingMethod method;

@property (nonatomic, copy) UICountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) void (^completionBlock)();
/**
 Calls countFrom with a given starting value and ending value, and a set duration.
 @param startValue
 The value which should be started counting from.
 @param endValue
 The value till which should be counted to.
 */
-(void)countFrom:(float)startValue to:(float)endValue;
/**
 counts from a starting value to an endingvalue in a given amount of time
 @param startValue
 The value which should be started counting from.
 @param endValue
 The value till which should be counted to.
 @param duration
 How much time it should take to count from start to endingvalue.
 */
-(void)countFrom:(float)startValue to:(float)endValue withDuration:(NSTimeInterval)duration;
@end
