//
//  ISpyProgressView.m
//  TimerProject
//
//  Created by justin on 10/15/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "ISpyProgressView.h"
#import "UICountingLabel.h"

@implementation ISpyProgressView
@synthesize time;
@synthesize labelPosition;

-(id) initWithTimerLabel:(bool)label LabelPosition:(UILabelPosition)_labelPosition Frame:(CGRect *)_frame
{
    self = [super init];
    if(self){
        adding = false;
        [self setProgress:1.0f animated:NO];
        self.frame = *(_frame);
        labelTimerActive = label;
        labelPosition = _labelPosition;
        
        if(labelTimerActive)
        {
            [self initTimerLabel];
        }
    }
    
    return self;
}

-(void)startTimer
{
    if(!timer)
    {
        timer = [NSTimer timerWithTimeInterval:(0.2f) target:self selector:@selector(updateValue:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)stopTimer
{
    if(timer != nil)
    {
        [timer invalidate];
        timer = nil;
    }
}

-(void)resetTimer
{
    time = initialTime;
    [self setProgress:1.0f animated:YES];
    
    if(labelTimerActive)
    {
        timerLabel.text = [NSString stringWithFormat:@"%.2f", [self progress] * time];
    }
}

-(void)setTime:(NSTimeInterval)setTime
{
    time = setTime;
    initialTime = setTime;
}

-(void)addTime:(float)addTime
{
    adding = true;

    float currentProgress = [self progress];
    float totalTime = currentProgress * time + addTime;
    
    if(totalTime > time){
        time +=  (addTime - (time - currentProgress * time));
    }
    
    [self setProgress:currentProgress +=addTime / time animated:YES];
    
    if(labelTimerActive)
    {
        timerLabel.text = [NSString stringWithFormat:@"%.2f", [self progress] * time];
        
    }
    
    adding = false;
}

-(void)updateValue:(NSTimer*)timer
{
    if(!adding){
        float currentProgress = [self progress];

        [self setProgress:currentProgress -=0.2f / time animated:YES];
        
        if(labelTimerActive)
        {
            timerLabel.text = [NSString stringWithFormat:@"%.2f", [self progress] * time];
            
        }
    }
}

-(bool)decreaseTime:(float)decreaseTime
{
    if(!adding){
        float currentProgress = [self progress] * time;
        
        if((currentProgress - decreaseTime)  <= 0)//GAME OVER
        {
            return false;
        }else
        {
            float progress = [self progress];
            
            [self setProgress:progress -= decreaseTime / time animated:YES];
            
            if(labelTimerActive)
            {
                timerLabel.text = [NSString stringWithFormat:@"%.2f", [self progress] * time];
                
            }
        }
    }
    
    return true;
}

-(void) initTimerLabel
{
    int x, y;
    
    switch(self.labelPosition)
    {
        case UILabelLeft:
            x = -23;
            y = -4;
            break;
        case UILabelRight:
            x = self.frame.size.width + 2;;
            y = -4;
            break;
    }

    CGRect labelFrame = CGRectMake(x, y, 30, 10);
    
    timerLabel = [[UILabel alloc] initWithFrame:labelFrame];
    timerLabel.text = [NSString stringWithFormat:@"%.2f", [self progress] * time];
    [timerLabel setFont: [UIFont fontWithName:@"Arial" size:8.0]];
    
    [self addSubview:timerLabel];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
