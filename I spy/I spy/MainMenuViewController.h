//
//  MainMenuViewController.h
//  I spy
//
//  Created by Julian Profas on 10/22/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MainMenuViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (strong, nonatomic) UIImage *capturedImage;

@end
