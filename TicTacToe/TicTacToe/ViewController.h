//
//  ViewController.h
//  TicTacToe
//
//  Created by Julian Profas on 9/9/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UILabel *lblInfo;
    NSArray *buttons;
    int counter;
    BOOL gameOver;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    UIButton *btn7;
    UIButton *btn8;
    UIButton *btn9;
}
@property (nonatomic, retain) IBOutlet UILabel *lblInfo;
@property (nonatomic, retain) IBOutlet UIButton *btn1;
@property (nonatomic, retain) IBOutlet UIButton *btn2;
@property (nonatomic, retain) IBOutlet UIButton *btn3;
@property (nonatomic, retain) IBOutlet UIButton *btn4;
@property (nonatomic, retain) IBOutlet UIButton *btn5;
@property (nonatomic, retain) IBOutlet UIButton *btn6;
@property (nonatomic, retain) IBOutlet UIButton *btn7;
@property (nonatomic, retain) IBOutlet UIButton *btn8;
@property (nonatomic, retain) IBOutlet UIButton *btn9;
- (IBAction)resetButton:(id)sender;
- (IBAction)changeChar:(id)sender;
- (void) computerStep;
- (int) checkWin;
@end
