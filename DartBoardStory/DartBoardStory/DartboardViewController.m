//
//  DartboardViewController.m
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "DartboardViewController.h"
#import "Dartboard.h"

@implementation DartboardViewController
@synthesize horizontalSlider;
@synthesize verticalSlider;
@synthesize croshairView;
@synthesize dartboardView;
@synthesize fireDart;
@synthesize dartboard;
@synthesize lblScore;

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (void)viewDidLoad
{
    [self setupVerticalSlider];
    [self.fireDart setHidden:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGPoint dartboardPosition = dartboardView.center;
    dartboard = [[Dartboard alloc] initWithDartboardViewController:self centerYPosition:dartboardPosition.y centerXPosition:dartboardPosition.x];
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

- (IBAction)fireButtonPressed:(id)sender {
    int dartXPosition = croshairView.center.x+[dartboard getRandomDartCoordinate];
    int dartYPosition = croshairView.center.y+[dartboard getRandomDartCoordinate];
    
    [self.fireDart setHidden:NO];
    self.fireDart.center = CGPointMake(dartXPosition, dartYPosition);
    int score = [dartboard getScoreXPosition:dartXPosition dartYPostion:dartYPosition];
    
    if(score > 0){
        self.lblScore.text = [NSString stringWithFormat:@"%d",score];
    }else{
        self.lblScore.text = @"MISS";
    }
}

- (IBAction)horizontalChange:(id)sender {
    int temp = (int)(horizontalSlider.value+0.5f);
    croshairView.center =CGPointMake(temp+28, croshairView.center.y);
}

- (void)setupVerticalSlider{
    //Create a transformation with just the rotation
    CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90));
    
    //Now apply our scale
    transform = CGAffineTransformScale(transform, 1, 1);
    
    //Now set the transform on the object to the combined rotation/scale transform.
    [self.verticalSlider setTransform: transform];
    
    CGAffineTransform sliderRotation = CGAffineTransformIdentity;
    sliderRotation = CGAffineTransformRotate(sliderRotation, -DEGREES_TO_RADIANS(-90));
    
    self.verticalSlider.transform = sliderRotation;
}

@end
