//
//  SinglePlayerViewController.h
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISpyProgressView.h"
#import "UICountingLabel.h"
#import "Constants.h"

@class BLRView;

@interface SinglePlayerViewController : UIViewController
{
    ISpyProgressView *progressBar;
    UICountingLabel *scoreLabel;
    UIImage *capturedImage;
    NSMutableSet *highlighted;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *presentedImage;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic, strong) IBOutlet UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) BLRView *blrView;
@property(nonatomic, assign) ViewDirection viewDirection;
@property (strong, nonatomic) IBOutlet UIView *BlurView;

-(void)highlightAnswer;
-(void)deHighlight;
-(IBAction)toggleViewDirection:(id)sender;
-(void)viewWillDisappear:(BOOL)animated;

@end
