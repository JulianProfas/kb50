//
//  ViewController.m
//  TimerProject
//
//  Created by justin on 10/15/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "ViewController.h"
#import "ISpyProgressView.h"
#import "Player.h"
#import "UICountingLabel.h"

@interface ViewController ()
#define GOOD_GUESS 10
#define BAD_GUESS 5
@end

@implementation ViewController
@synthesize start;
@synthesize stop;
@synthesize reset;
@synthesize good;
@synthesize bad;
@synthesize label;

- (void)viewDidLoad
{
   [super viewDidLoad];
    
    player = [[Player alloc] initWithScore:100];
    CGRect barFrame = CGRectMake(100,100,100,20);
    bar = [[ISpyProgressView alloc] initWithTimerLabel:YES LabelPosition:UILabelRight Frame:&barFrame];

    [self.view addSubview:bar];
    
    [bar setTime:10.0f];
    label.text = [NSString stringWithFormat:@"%d", player.score];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender
{
    [bar startTimer];
}

- (IBAction)stopButtonPressed:(id)sender
{
    [bar stopTimer];
}

- (IBAction)resetButtonPressed:(id)sender
{
    [bar resetTimer];
}

-(IBAction)goodButtonPressed:(id)sender
{
    [self updateScore];

    [bar addTime:GOOD_GUESS];
}

-(IBAction)badButtonPressed:(id)sender
{
    if(![bar decreaseTime:BAD_GUESS]){
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        
        UILabel *lbl1 = [[UILabel alloc] init];
        [lbl1 setFrame:CGRectMake(0,0,screenSize.height,screenSize.width)];
        lbl1.backgroundColor=[UIColor blackColor];
        lbl1.textColor=[UIColor whiteColor];
        lbl1.userInteractionEnabled=YES;
        [self.view addSubview:lbl1];
        lbl1.text= @"YOU LOSE";
    }
}

-(void)updateScore
{
    int previousScore = player.score;
    player.score += [self getScoreByDifficulty];
    
    // count up using a string that uses a number formatter
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    label.formatBlock = ^NSString* (float value)
    {
        NSString* formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"%@",formatted];
    };
    label.method = UILabelCountingMethodEaseOut;
    [label countFrom:previousScore to:[player score] withDuration:2];
    
    //[label setText:[NSString stringWithFormat:@"Score : %d",[player score]]];
}

-(int)getScoreByDifficulty
{
    int difficulty = 0; //ophalen uit settings class
    int score = 0;
    
    switch (difficulty) {
        case 0: //Easy
            score = 100;
            break;
        case 1: //Medium
            score = 75;
            break;
        case 2: //Hard
            score = 50;
            break;
        default:
            score = 100;
            break;
    }
    
    return score;
}

@end
