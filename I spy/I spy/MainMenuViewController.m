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
@synthesize takePictureButton;
@synthesize capturedImage;
@synthesize myImageView;
@synthesize messageLabel;

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
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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
    /*UIImage *chosenImage =  [self imageWithImage:[UIImage imageNamed:@"holi-colors_hd.jpg"] scaledToSize:CGSizeMake(320, 480)];
    capturedImage = chosenImage;
    [self performSegueWithIdentifier:@"gameSegue" sender:self];*/
    
    [self startCameraControllerFromViewController: self usingDelegate: self];
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
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:NO completion:^{ }];
    
    return YES;
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
    }
}

- (IBAction)bounce:(id)sender
{
    [myImageView bounce:0.05f];
}

- (IBAction)pan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    //NSLog(@"printing center y: %f", recognizer.view.center.y);
    if (recognizer.view.center.y + translation.y < 284) {       //only allow upwards pans
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (recognizer.view.center.y < 0) {           //open screen completely
            CGRect outOfScreenPosition = CGRectMake(0, -568, 320, 568);
            
            [UIView animateWithDuration:0.8 animations:^{ myImageView.frame = outOfScreenPosition; } completion:^ (BOOL finished) {
                if (finished) { [self takePicture]; } }];
        } else if (recognizer.view.center.y <= 284){     //move back to closed position
            CGRect outOfScreenPosition = CGRectMake(0, 0, 320, 568);
            
            [UIView animateWithDuration:0.8 animations:^{ myImageView.frame = outOfScreenPosition; }];
        }
    }
}

-(void) SinglePlayerViewControllerDismissed:(NSString *)message
{
    messageLabel.text = message;
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
