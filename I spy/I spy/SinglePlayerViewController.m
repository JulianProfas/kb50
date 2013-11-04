//
//  SinglePlayerViewController.m
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/7/13.
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
@synthesize singlePlayerViewControllerDelegate;
@synthesize mainMenu;
@synthesize notification;
@synthesize myImage;

#define MATRIXWIDTH 40
#define MATRIXHEIGHT 60
#define SQUAREWIDTH 8
#define SQUAREHEIGHT 8

#pragma standard iOS Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    mainMenu = [[UIImageView alloc] initWithImage:myImage];
    mainMenu.frame = CGRectMake(0, -568, 320, 568);
    [self.view addSubview:mainMenu];
    
    Game *iSpyWithMyLittleEye = [Game sharedManager];
    [iSpyWithMyLittleEye setCapturedImage:capturedImage];
    [iSpyWithMyLittleEye setScoreLabel:scoreLabel];
    [iSpyWithMyLittleEye setNavigationBar:navigationBar];
    
    
    [iSpyWithMyLittleEye setupGame];
    [iSpyWithMyLittleEye setAnswerLabel];
    if ([navigationBar.topItem.title isEqualToString:@"loading..."]) {
        notification = @"Please take a more colorful picture";
        [self closeAnimation];
    } else {
        CGRect barFrame = CGRectMake(0,42,320,20);
        progressBar = [[ISpyProgressView alloc] initWithTimerLabel:YES LabelPosition:UILabelRight Frame:&barFrame];
        [iSpyWithMyLittleEye setProgressBar:progressBar];
        [self.view addSubview:progressBar];
        scoreLabel.text = [NSString stringWithFormat:@"Score %d", [[Player sharedManager] score]];
        presentedImage.image = [[iSpyWithMyLittleEye currentPhoto] capturedImage];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkTimer) userInfo:nil repeats:YES];
        [iSpyWithMyLittleEye startGame];
        [self.view setUserInteractionEnabled:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    
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
    
    if(!touchMoved)
    {
        CGPoint location = [touch locationInView:self.presentedImage];
        
        int squareXcoordinate = location.x / SQUAREWIDTH;
        int squareYcoordinate = location.y / SQUAREHEIGHT;
        
        CGPoint guessCoordinates = {squareXcoordinate, squareYcoordinate};
        //NSLog(@"Guess coordinates: %@", NSStringFromCGPoint(guessCoordinates));
        
        Game *iSpyWithMyLittleEye = [Game sharedManager];
        
        Photo *myPhoto = [iSpyWithMyLittleEye currentPhoto];
        if(squareYcoordinate < MATRIXHEIGHT)
        {
            Color *myColor = [[myPhoto.colorMatrix objectAtIndex:squareXcoordinate] objectAtIndex:squareYcoordinate];
            NSLog(@"%@", myColor.hsv);
        }
        
        if ([iSpyWithMyLittleEye checkAnswer: guessCoordinates])
        {
            [self.view setUserInteractionEnabled:NO];
            NSLog(@"guessing something");
            [self highlightAnswer];
            
            iSpyWithMyLittleEye.time = 30;
            [iSpyWithMyLittleEye roundOver];
            [timer invalidate];
            timer = nil;
            
            if (iSpyWithMyLittleEye.round == 0) {
                iSpyWithMyLittleEye.round = 1;
            }
            
            notification = @"You won the round";
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(closeAnimation)
                                           userInfo:nil
                                            repeats:NO];
        }
    }
}

#pragma mark - Highlight Methods

-(void)highlightAnswer
{
    if(highlighted == NULL){
        highlighted = [[NSMutableSet alloc] init];
    }else{
        [self deHighlight];
    }
    
    for(NSValue *value in [[Game sharedManager] answers]){
        HighlightView *highlight = [[HighlightView alloc] initWithFrame:CGRectMake(value.CGPointValue.x * SQUAREWIDTH, value.CGPointValue.y * SQUAREHEIGHT, SQUAREWIDTH, SQUAREHEIGHT)];
        highlight.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.50];
        
        [highlighted addObject:highlight];
        [presentedImage addSubview:highlight];
    }
}

-(void)deHighlight
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

-(void)checkTimer
{
    Game *iSpyWithMyLittleEye = [Game sharedManager];
    if(progressBar.progress <= 0){
        [self.view setUserInteractionEnabled:NO];
        
        [self highlightAnswer];
        
        iSpyWithMyLittleEye.round = 1;
        iSpyWithMyLittleEye.time = 0;
        [Player sharedManager].score = 0;
        
        [timer invalidate];
        timer = nil;
        
        notification = @"Game Over";
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(closeAnimation)
                                       userInfo:nil
                                        repeats:NO];
    }
}

-(void)closeAnimation
{
    [self deHighlight];
    [progressBar removeFromSuperview];
    
    CGRect normalScreenPosition = CGRectMake(0, 0, 320, 568);
    [UIView animateWithDuration:0.5 animations:^{ mainMenu.frame = normalScreenPosition; } completion:^ (BOOL finished) {
        if (finished) {
            
            if([self.singlePlayerViewControllerDelegate respondsToSelector:@selector(SinglePlayerViewControllerDismissed:round:score:time:)])
            {
                Game *iSpyWithMyLittleEye = [Game sharedManager];
                [self.singlePlayerViewControllerDelegate SinglePlayerViewControllerDismissed:notification round:iSpyWithMyLittleEye.round score:[Player sharedManager].score time:iSpyWithMyLittleEye.time];
            }
            [self dismissViewControllerAnimated:NO completion:^ {
                Game *iSpyWithMyLittleEye = [Game sharedManager];
                if ([notification isEqualToString:@"You won the round"]) {
                    iSpyWithMyLittleEye.round++;
                }
                 }];
        }
    }];
}


@end
