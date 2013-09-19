//
//  DartboardViewController.m
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "DartboardViewController.h"

@implementation DartboardViewController
@synthesize horizontalSlider;
@synthesize verticalSlider;
@synthesize croshairView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)verticalChange:(id)sender {
    int temp = (int)(verticalSlider.value+0.5f);
    croshairView.center = CGPointMake(croshairView.center.x, temp+89);
}
- (IBAction)horizontalChange:(id)sender {
    int temp = (int)(horizontalSlider.value+0.5f);
    croshairView.center =CGPointMake(temp+48, croshairView.center.y);
}
@end
