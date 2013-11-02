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
@property (nonatomic, weak) IBOutlet UIButton *takePictureButton;
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, weak) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@end
