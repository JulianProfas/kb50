//
//  MainMenuViewController.m
//  I spy
//
//  Created by iOS Team on 10/22/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SinglePlayerViewController.h"
#import "UIView+Bounce.h"

@interface MainMenuViewController ()
@end

@implementation MainMenuViewController
{
    ADBannerView *_bannerView;
    NSTimer *_timer;
    CFTimeInterval _ticks;
}
@synthesize capturedImage;
@synthesize mainMenu;
@synthesize messageLabel;
@synthesize roundLabel;
@synthesize scoreLabel;
@synthesize timeLabel;
@synthesize animationView;
@synthesize _imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setRandomBackground];
    _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    [self.view addSubview:_bannerView];
    _bannerView.delegate = self;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Main Menu Class Methods

- (void)setRandomBackground
{
    NSInteger randomNumber =  arc4random_uniform(4);
    UIImage *randomImage;
    
    switch (randomNumber) {
        case 0:
            randomImage = [UIImage imageNamed:@"mainmenu1.png"];
            break;
        case 1:
            randomImage = [UIImage imageNamed:@"mainmenu2.png"];
            break;
        case 2:
            randomImage = [UIImage imageNamed:@"mainmenu3.png"];
            break;
        case 3:
            randomImage = [UIImage imageNamed:@"mainmenu4.png"];
            break;
        default:
            break;
    }
    
    mainMenu.image = randomImage;
}

#pragma mark - Image Picker Controller Delegate Methods

-(void)ImagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    capturedImage = [self imageWithImage:chosenImage scaledToSize:CGSizeMake(320, 480)];
    
    [self dismissViewControllerAnimated:NO completion:^{
        [self performSegueWithIdentifier:@"gameSegue" sender:self];
    }];
}

#pragma mark - Action Methods

- (IBAction)takePicture
{
    if (self.imagePicker)
    {
        [self presentViewController:self.imagePicker animated:NO completion:^{}];
    }
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate
{
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    [self takePicture];
    
    return YES;
}

-(UIImagePickerController *) imagePicker{
    if(!_imagePicker){
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else{
            _imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
    }
    return _imagePicker;
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gameSegue"]) {
        SinglePlayerViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.singlePlayerViewControllerDelegate = self;
        destinationViewController.capturedImage = capturedImage;
        destinationViewController.myImage = mainMenu.image;
    }
}

- (IBAction)bounce:(id)sender
{
    [animationView bounce:0.05f];
}

- (IBAction)pan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    //NSLog(@"printing center y: %f", recognizer.view.center.y);
    if (recognizer.view.center.y + translation.y < 284) { //only allow upwards pans
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat velocityY = [recognizer velocityInView:self.view].y;
        
        CGPoint endPosition = CGPointMake(160, -284);
        NSTimeInterval duration = endPosition.y / velocityY;
        
        if (duration > 0.5){
            duration = 0.5;
        }
        
        if (recognizer.view.center.y <= 0 || velocityY < -500) { //open screen completely
            [UIView animateWithDuration:duration animations:^{ animationView.center = endPosition; } completion:^ (BOOL finished) {
                if (finished) { [self takePicture]; } }];
        } else if (recognizer.view.center.y <= 284){ //move back to closed position
            CGPoint startPosition = CGPointMake(160, 284);
            [UIView animateWithDuration:0.5 animations:^{ animationView.center = startPosition; }];
        }
    }
}

-(void) SinglePlayerViewControllerDismissed:(NSString *)message round:(int)round score:(int)score time:(int)time
{
    if ([message isEqualToString:@"Please take a more colorful picture"]) {
        messageLabel.text = message;
    } else if ([message isEqualToString:@"Game Over"] && round == 1) {
        messageLabel.text = message;
    } else {
        roundLabel.text = [NSString stringWithFormat:@"Round %d completed!",round];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %d Points",score];
        timeLabel.text = [NSString stringWithFormat:@"+%d seconds",time];
    }
}

#pragma mark iAd Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

@end
