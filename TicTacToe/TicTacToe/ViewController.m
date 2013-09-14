//
//  ViewController.m
//  TicTacToe
//
//  Created by Julian Profas on 9/9/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

@interface ViewController ()
@end

@implementation ViewController
@synthesize lblInfo;
@synthesize btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9;

- (void)resetButton:(id)sender
{

    for(UIButton *btnPointer in buttons){
        if(btnPointer != nil){
            [btnPointer setTitle:@" " forState:UIControlStateNormal];
        }
    }
    
    lblInfo.text = @"";
    gameOver = FALSE;
    counter = 0;
}

- (void)changeChar:(id)sender
{
    if(!gameOver){
        UIButton *selectedButton = sender;
    
        NSString *title= selectedButton.titleLabel.text;
        if([title isEqualToString: @" "])
        {
            [selectedButton setTitle:@"X" forState:UIControlStateNormal];
            if(![self checkWin]){
                [self computerStep];
                [self checkWin];
            }
        }
    
        [selectedButton release];
        selectedButton = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view,

    buttons = [[NSArray alloc] initWithObjects:btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, nil];
    counter = 0;
    gameOver = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    for(UIButton *btnPointer in buttons){
        if(btnPointer != nil){
            [btnPointer release];
        }
    }
    
    [lblInfo release];
    [buttons release];
    [super dealloc];
}

-(void)computerStep
{    
    if(counter > 3){return;}
    int r = arc4random() % 9;
    
    UIButton *curButton = [buttons objectAtIndex:r];
    NSString *title=curButton.titleLabel.text;
    
    while(![title isEqualToString: @" "]){
        curButton = [buttons objectAtIndex:r];
        title=curButton.titleLabel.text;
        
        r = arc4random() % 9;
        
    }
    counter ++;
    [curButton setTitle:@"O" forState:UIControlStateNormal];
}

-(BOOL)checkWin{
    /**
     * Check for win in the leftmost column and in the topmost row.
     */
    
    if(![btn1.titleLabel.text isEqualToString: @" "]) {
        if ((([btn1.titleLabel.text isEqualToString: btn2.titleLabel.text]) && ([btn1.titleLabel.text isEqualToString: btn3.titleLabel.text])) ||
            (([btn1.titleLabel.text isEqualToString: btn4.titleLabel.text]) && ([btn1.titleLabel.text isEqualToString: btn7.titleLabel.text]))) {
            lblInfo.text = [NSString stringWithFormat: @"%@ heeft gewonnen!", btn1.titleLabel.text];
            gameOver = TRUE;
            
            return TRUE;
        }
    }
    
    /**
     * Check for wins that go through the middle of the board.
     */
    if(![btn5.titleLabel.text isEqualToString: @" "]) {
        if ((([btn5.titleLabel.text isEqualToString: btn4.titleLabel.text]) && ([btn5.titleLabel.text isEqualToString: btn6.titleLabel.text])) ||
            (([btn5.titleLabel.text isEqualToString: btn2.titleLabel.text]) && ([btn5.titleLabel.text isEqualToString: btn8.titleLabel.text])) ||
            (([btn5.titleLabel.text isEqualToString: btn1.titleLabel.text]) && ([btn5.titleLabel.text isEqualToString: btn9.titleLabel.text])) ||
            (([btn5.titleLabel.text isEqualToString: btn3.titleLabel.text]) && ([btn5.titleLabel.text isEqualToString: btn7.titleLabel.text]))) {
            lblInfo.text = [NSString stringWithFormat: @"%@ heeft gewonnen!", btn5.titleLabel.text];
            gameOver = TRUE;
            
            return TRUE;
        }
    }
    
    /**
     * Check for win in the rightmost column and in the lowest row.
     */
    if(![btn9.titleLabel.text isEqualToString: @" "]) {
        if ((([btn9.titleLabel.text isEqualToString: btn6.titleLabel.text]) && ([btn9.titleLabel.text isEqualToString: btn3.titleLabel.text])) ||
            (([btn9.titleLabel.text isEqualToString: btn8.titleLabel.text]) && ([btn9.titleLabel.text isEqualToString: btn7.titleLabel.text]))) {
            lblInfo.text = [NSString stringWithFormat: @"%@ heeft gewonnen!", btn9.titleLabel.text];
            gameOver = TRUE;
            
            return TRUE;
        }
    }
    
    return FALSE;
}

@end
