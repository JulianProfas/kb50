//
//  ViewController.h
//  TimerProject
//
//  Created by justin on 10/15/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISpyProgressView.h"
#import "Player.h"
#import "UICountingLabel.h"

@interface ViewController : UIViewController
{
    ISpyProgressView *bar;
    Player *player;
    UIButton *start;
    UIButton *stop;
    UIButton *reset;
    UIButton *good;
    UIButton *bad;
    UICountingLabel *label;
}
@property (nonatomic, retain) IBOutlet UIButton *start;
@property (nonatomic, retain) IBOutlet UIButton *stop;
@property (nonatomic, retain) IBOutlet UIButton *reset;
@property (nonatomic, retain) IBOutlet UIButton *good;
@property (nonatomic, retain) IBOutlet UIButton *bad;
@property (nonatomic, strong) IBOutlet UICountingLabel *label;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)goodButtonPressed:(id)sender;
- (IBAction)badButtonPressed:(id)sender;
-(void) updateScore;
-(int) getScoreByDifficulty;
@end
