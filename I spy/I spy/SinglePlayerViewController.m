//
//  SinglePlayerViewController.m
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "Game.h"
#import "Player.h"
#import "Color.h"

@interface SinglePlayerViewController ()
@end

@implementation SinglePlayerViewController
@synthesize presentedImage;
@synthesize touchMoved;
@synthesize scoreLabel;
@synthesize navigationBar;
@synthesize capturedImage;
@synthesize spinner;

#pragma standard iOS Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    Game *iSpyWithMyLittleEye = [Game sharedManager];
    [iSpyWithMyLittleEye setCapturedImage:capturedImage];
    [iSpyWithMyLittleEye setScoreLabel:scoreLabel];
    [iSpyWithMyLittleEye setNavigationBar:navigationBar];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [iSpyWithMyLittleEye setSpinner:spinner];
    [self.view addSubview:spinner];
    
    dispatch_queue_t photoQueue = dispatch_queue_create("loading", NULL);
    dispatch_async(photoQueue, ^{
        [iSpyWithMyLittleEye setupGame];
        dispatch_async(dispatch_get_main_queue(), ^{
            [iSpyWithMyLittleEye setAnswerLabel];
            if ([navigationBar.topItem.title isEqualToString:@"Not Found"]) {
                [spinner stopAnimating];
                [self dismissViewControllerAnimated:YES completion:^ {}];
            } else {
                [spinner stopAnimating];
                
                CGRect barFrame = CGRectMake(0,42,320,20); //todo: remove off screen counter, no need for the counter
                progressBar = [[ISpyProgressView alloc] initWithTimerLabel:YES LabelPosition:UILabelRight Frame:&barFrame];
                [iSpyWithMyLittleEye setProgressBar:progressBar];
                [self.view addSubview:progressBar];
                
                scoreLabel.text = [NSString stringWithFormat:@"%d", [[Player sharedManager] score]];
                presentedImage.image = [[iSpyWithMyLittleEye currentPhoto] pixelatedImage];
                
                [iSpyWithMyLittleEye startGame];
            }
        });
        
    });
    
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch Methods

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoved = NO;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoved = YES;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    //check if the person tabbed or moved
    if(!touchMoved)
    {
        //location of where the player touched the screen
        CGPoint location = [touch locationInView:self.presentedImage];
        
        double MatrixHeight = 1 / 0.025f;
        double MatrixWidth = MatrixHeight * 3 / 4;
        
        double squareWidth = 320 / MatrixWidth;
        double squareHeight = 480 / MatrixHeight;
        
        int boxXcoordinate = location.x / squareWidth;
        int boxYcoordinate = location.y / squareHeight;
        
        NSLog(@"location.x: %f", location.x);
        NSLog(@"location.y: %f", location.y);
        
        CGPoint guessCoordinates = {boxXcoordinate, boxYcoordinate};
        NSLog(@"Guess coordinates: %@", NSStringFromCGPoint(guessCoordinates));
        
        Game *iSpyWithMyLittleEye = [Game sharedManager];
        Photo *currentPhoto = [iSpyWithMyLittleEye currentPhoto];
        
        UIColor *selectedColor = [currentPhoto getPixelColor:currentPhoto.pixelatedImage xCoordinate:(boxXcoordinate * squareWidth) + (squareWidth / 2) yCoordinate:(boxYcoordinate * squareWidth) + (squareWidth / 2)];
        
        Color *color = [[Color alloc]initWithColor:selectedColor];
        NSLog(@"color clicked on: %@", color.colorName);
        
        [iSpyWithMyLittleEye checkAnswer: guessCoordinates];
    }
}

@end
