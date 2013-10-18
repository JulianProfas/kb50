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
@synthesize fireButton;
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

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


//Override to change the size of the images when rotating to landscape view.
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        dartboardView.frame = CGRectMake(self.view.center.y - 125, self.view.center.x - 125, 250, 250);
        croshairView.frame = CGRectMake(self.view.center.y - 25, self.view.center.x - 25, 50, 50);
        verticalSlider.frame = CGRectMake(self.view.center.y - 150, self.view.center.x - 125, 0, 250);
        horizontalSlider.frame = CGRectMake(self.view.center.y - 125, self.view.center.x + 125, 250, 0);
        lblScore.frame = CGRectMake(self.view.center.y - 200, self.view.center.x - 10, 50, 20);
        fireButton.frame = CGRectMake(self.view.center.y + 150, self.view.center.x - 25, 100, 50);
        horizontalSlider.value = 125;
        verticalSlider.value = 125;
    }
    else{
        dartboardView.frame = CGRectMake(self.view.center.x - 125, self.view.center.y - 125, 250, 250);
        croshairView.frame = CGRectMake(self.view.center.x - 25, self.view.center.y - 25, 50, 50);
        verticalSlider.frame = CGRectMake(self.view.center.x - 150, self.view.center.y - 125, 0, 250);
        horizontalSlider.frame = CGRectMake(self.view.center.x - 125, self.view.center.y + 125, 250, 0);
        lblScore.frame = CGRectMake(self.view.center.x - 25, self.view.center.y - 200, 50, 20);
        fireButton.frame = CGRectMake(self.view.center.x - 50, self.view.center.y + 150, 100, 50);
        horizontalSlider.value = 125;
        verticalSlider.value = 125;
    }
    
    CGPoint dartboardPosition = dartboardView.center;
    dartboard.dartboardCenterXPosition = dartboardPosition.x;
    dartboard.dartboardCenterYPosition = dartboardPosition.y;
}

- (IBAction)verticalChange:(id)sender {
    int temp = (int)(verticalSlider.value+0.5f);
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){
        croshairView.center = CGPointMake(croshairView.center.x, temp + 35);
    }
    else{
        croshairView.center = CGPointMake(croshairView.center.x, temp + 159);
    }
}

- (IBAction)horizontalChange:(id)sender {
    int temp = (int)(horizontalSlider.value+0.5f);
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){
        croshairView.center = CGPointMake(temp + 159, croshairView.center.y);
    }
    else{
        croshairView.center = CGPointMake(temp + 35, croshairView.center.y);
    }
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
