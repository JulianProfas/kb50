//
//  ViewController.m
//  Highlight
//
//  Created by justin on 10/28/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "ViewController.h"
#import "HighlighView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    matrix = [[NSMutableSet alloc] initWithObjects:
              [NSValue valueWithCGPoint:CGPointMake(2, 5)],
              [NSValue valueWithCGPoint:CGPointMake(3, 5)],
              [NSValue valueWithCGPoint:CGPointMake(4, 5)],
              [NSValue valueWithCGPoint:CGPointMake(5, 5)],
              [NSValue valueWithCGPoint:CGPointMake(6, 5)],
              [NSValue valueWithCGPoint:CGPointMake(3, 6)],
              [NSValue valueWithCGPoint:CGPointMake(4, 6)],
              [NSValue valueWithCGPoint:CGPointMake(5, 6)],
              [NSValue valueWithCGPoint:CGPointMake(4, 7)],
              nil];// Do any additional setup after loading the view, typically from a nib.
    
    [self highlightAnswer];
    //[self deHighlight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)highlightAnswer
{
    if(highlighted == NULL){
        highlighted = [[NSMutableSet alloc] init];
    }
    
    double MatrixHeight = 1 / 0.025f;
    double MatrixWidth = MatrixHeight * 3 / 4;
    
    double squareWidth = 320 / MatrixWidth;
    double squareHeight = 480 / MatrixHeight;
    
    for(NSValue *value in matrix){
        HighlighView *highlight = [[HighlighView alloc] initWithFrame:CGRectMake(value.CGPointValue.x * squareWidth, value.CGPointValue.y * squareHeight, squareWidth, squareHeight)];
        highlight.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.50];
    
        [highlighted addObject:highlight];
        [self.view addSubview:highlight];
        
        printf("x: %d y: %d \n", (int)(value.CGPointValue.x * squareWidth), (int)(value.CGPointValue.y * squareHeight));
    }
    
}

-(void)deHighlight
{
    for (UIView *subview in [self.view subviews]) {
        for(HighlighView *view in highlighted){
            if(subview == view){
                [subview removeFromSuperview];
            }
        }
    }
    
    [highlighted removeAllObjects];
}

@end
