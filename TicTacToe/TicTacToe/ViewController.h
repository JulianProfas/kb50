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
- (BOOL) checkWin;
@end
