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
        btnPointer.titleLabel.text = @" ";
        [btnPointer setTitle:@" " forState:UIControlStateNormal];
    }
    
    lblInfo.text = @"";
    gameOver = FALSE;
    counter = 0;
}

- (void)changeChar:(id)sender
{
    if(!gameOver){
        UIButton *selectedButton = sender;
    
        if([selectedButton.titleLabel.text isEqualToString: @" "])
        {

            selectedButton.titleLabel.text = @"X";
            [selectedButton setTitle:@"X" forState:UIControlStateNormal];
            
            int result = [self checkWin];
            
            if(result == 0){
                [self computerStep];
                int nextResult = [self checkWin];
                if(nextResult != 0){
                    lblInfo.text = [NSString stringWithFormat: @"%@ heeft gewonnen!", [self getButtonNumber:nextResult].titleLabel.text];
                    gameOver = true;
                }
            }else{
                lblInfo.text = [NSString stringWithFormat: @"%@ heeft gewonnen!", [self getButtonNumber:result].titleLabel.text];
                gameOver = true;
            }
        }
        
        for(UIButton *btnPointer in buttons){
            if(btnPointer != nil){
                NSLog([NSString stringWithFormat:@"%@", btnPointer.titleLabel.text]);        }
        }
        
        //[selectedButton release];
        //selectedButton = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view,

    buttons = [[NSArray alloc] initWithObjects:btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, nil];
    counter = 0;
    gameOver = FALSE;
    
    for(UIButton *btnPointer in buttons){
        btnPointer.titleLabel.text = @" ";
        [btnPointer setTitle:@" " forState:UIControlStateNormal];
    }
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
    int r = arc4random() % 8;
    
    UIButton *curButton = [buttons objectAtIndex:r];
    NSString *title=curButton.titleLabel.text;
    
    while(![title isEqualToString: @" "]){
        curButton = [buttons objectAtIndex:r];
        title=curButton.titleLabel.text;
        
        r = arc4random() % 8;
        
    }
    counter ++;
    curButton.titleLabel.text = @"O";
    [curButton setTitle:@"O" forState:UIControlStateNormal];
    NSLog([NSString stringWithFormat:@"%d", r]);
}

-(int)checkWin
{

    //method that will check to see if someone has won returns TRUE if someone wins
        // HORIZONTAL WINS
        if(([btn1.titleLabel.text isEqualToString: btn2.titleLabel.text]) && ([btn2.titleLabel.text isEqualToString: btn3.titleLabel.text]) && ![(btn1.titleLabel.text)  isEqualToString: @" "])
        {
            return 1;
        }
        if(([btn4.titleLabel.text isEqualToString: btn5.titleLabel.text]) & ([btn5.titleLabel.text isEqualToString: btn6.titleLabel.text]) & (![btn4.titleLabel.text  isEqualToString: @" "]))
        {
            return 2;
        }
        if(([btn7.titleLabel.text isEqualToString: btn8.titleLabel.text]) & ([btn8.titleLabel.text isEqualToString: btn9.titleLabel.text]) & (![btn7.titleLabel.text  isEqualToString: @" "]))
        {
            return 3;
        }
        // VERTICAL WINS
        if(([btn1.titleLabel.text isEqualToString: btn4.titleLabel.text]) & ([btn5.titleLabel.text isEqualToString: btn6.titleLabel.text]) & (![btn1.titleLabel.text isEqualToString: @" "]))
        {
            return 4;
        }
        if(([btn2.titleLabel.text isEqualToString: btn5.titleLabel.text]) & (([btn5.titleLabel.text isEqualToString: btn8.titleLabel.text]) & (![btn2.titleLabel.text  isEqualToString: @" "])))
        {
            return 5;
        }
        if(([btn3.titleLabel.text isEqualToString: btn6.titleLabel.text]) & ([btn6.titleLabel.text isEqualToString: btn9.titleLabel.text]) & (![btn3.titleLabel.text isEqualToString: @" "]))
        {
            return 6;
        }
        // DIAGONAL WINS
        if(([btn1.titleLabel.text isEqualToString: btn5.titleLabel.text]) & ([btn5.titleLabel.text isEqualToString: btn9.titleLabel.text]) & (![btn1.titleLabel.text  isEqualToString: @" "]))
        {
            return 7;
        }
        if(([btn3.titleLabel.text isEqualToString: btn5.titleLabel.text]) & ([btn5.titleLabel.text isEqualToString: btn7.titleLabel.text]) & (![btn3.titleLabel.text  isEqualToString: @" "]))
        {
            return 8;
        }
    
        //right now return 1 becuase we havn't implemented this yet
        return 0;
}

-(UIButton *) getButtonNumber:(int) number
{
    UIButton *button;
    switch (number) {
        case 1:
            button = btn1;
            break;
        case 2:
            button = btn4;
            break;
        case 3:
            button = btn7;
            break;
        case 4:
            button = btn1;
            break;
        case 5:
            button = btn2;
            break;
        case 6:
            button = btn3;
            break;
        case 7:
            button = btn1;
            break;
        case 8:
            button = btn3;
            break;
        default:
            button = nil;
            break;
    }
    
    return button;
}

@end
