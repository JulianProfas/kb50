//
//  MainMenuViewController.h
//  I spy
//
//  Created by iOS Team on 10/22/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MainMenuViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (strong, nonatomic) UIImage *capturedImage;

@property (nonatomic, strong) UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end
