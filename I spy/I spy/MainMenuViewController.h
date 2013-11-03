//
//  MainMenuViewController.h
//  I spy
//
//  Created by iOS Team on 10/22/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "SinglePlayerViewController.h"

@interface MainMenuViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SinglePlayerViewControllerDelegate, ADBannerViewDelegate>
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, weak) IBOutlet UIImageView *mainMenu;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *animationView;

- (void)setRandomBackground;

@end
