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
@synthesize fireDart;

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (void)viewDidLoad
{
    [self setupVerticalSlider];
    [self.fireDart setHidden:YES];
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

- (IBAction)fireButtonPressed:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int dificulty = (int)[prefs integerForKey:@"dificulty"];
    int randomFromTo = 0;
    if(dificulty == 0){
        randomFromTo = -3 + arc4random() % (3 - -3);
    }else if(dificulty == 1){
        randomFromTo = -10 + arc4random() % (10 - -10);
    }else if(dificulty == 2){
        randomFromTo = -30 + arc4random() % (30 - -30);
    }
    
    [self.fireDart setHidden:NO];
    self.fireDart.center = CGPointMake(croshairView.center.x+randomFromTo, croshairView.center.y+randomFromTo);
    
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
