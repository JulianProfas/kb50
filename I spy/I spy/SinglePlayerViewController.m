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
#import "HighlightView.h"

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
                
                CGRect barFrame = CGRectMake(0,42,320,20);
                progressBar = [[ISpyProgressView alloc] initWithTimerLabel:NO LabelPosition:UILabelRight Frame:&barFrame];
                [iSpyWithMyLittleEye setProgressBar:progressBar];
                [self.view addSubview:progressBar];
                
                scoreLabel.text = [NSString stringWithFormat:@"%d", [[Player sharedManager] score]];
                presentedImage.image = [[iSpyWithMyLittleEye currentPhoto] capturedImage];
                
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoved = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoved = YES;
}

static double const ISMatrixWidth = 40.0;
static double const ISMatrixHeight = 60.0;
static double const ISSquareWidth = 320;
static double const ISSquareHeight = 480;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    //check if the person tabbed or moved
    if(!touchMoved)
    {
        //location of where the player touched the screen
        CGPoint location = [touch locationInView:self.presentedImage];
        
        double squareWidth = ISSquareWidth / ISMatrixWidth;
        double squareHeight = ISSquareHeight / ISMatrixHeight;
        
        int boxXcoordinate = location.x / squareWidth; //8.0
        int boxYcoordinate = location.y / squareHeight; //8.0
        
        NSLog(@"location.x: %f", location.x);
        NSLog(@"location.y: %f", location.y);
        
        CGPoint guessCoordinates = {boxXcoordinate, boxYcoordinate};
        NSLog(@"Guess coordinates: %@", NSStringFromCGPoint(guessCoordinates));
        
        Game *iSpyWithMyLittleEye = [Game sharedManager];
        
        Photo *myPhoto = [iSpyWithMyLittleEye currentPhoto];
        if(boxYcoordinate < ISMatrixHeight)
        {
            Color *myColor = [[myPhoto.colorMatrix objectAtIndex:boxXcoordinate] objectAtIndex:boxYcoordinate];
            NSLog(@"%@", myColor.hsv);
        }
        
        if ([iSpyWithMyLittleEye checkAnswer: guessCoordinates]) {
            [self highlightAnswer];
        }
    }
}

#pragma mark - Highlight Debug Methods

- (void)highlightAnswer
{
    if(highlighted == NULL){
        highlighted = [[NSMutableSet alloc] init];
    }
    
    double squareWidth = ISSquareWidth / ISMatrixWidth;
    double squareHeight = ISSquareHeight / ISMatrixHeight;
    
    for(NSValue *value in [[Game sharedManager] answers]){
        HighlightView *highlight = [[HighlightView alloc] initWithFrame:CGRectMake(value.CGPointValue.x * squareWidth, value.CGPointValue.y * squareHeight, squareWidth, squareHeight)];
        highlight.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.50];
        
        [highlighted addObject:highlight];
        [presentedImage addSubview:highlight];
        
        //printf("x: %d y: %d \n", (int)(value.CGPointValue.x * squareWidth), (int)(value.CGPointValue.y * squareHeight));
    }
}

- (void)deHighlight:(id)sender
{
    for (UIView *subview in [self.view subviews]) {
        for(HighlightView *view in highlighted){
            if(subview == view){
                [subview removeFromSuperview];
            }
        }
    }
    [highlighted removeAllObjects];
}

@end
