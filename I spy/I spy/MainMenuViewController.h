//
//  MainMenuViewController.h
//  I spy
//
//  Created by iOS Team on 10/22/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SinglePlayerViewController.h"

@interface MainMenuViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SinglePlayerViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UIButton *takePictureButton;
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, weak) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
