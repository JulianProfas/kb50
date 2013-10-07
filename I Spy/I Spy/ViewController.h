//
//  ViewController.h
//  I Spy
//
//  Created by Allard Soeters on 04-10-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController{
    UIImageView *displayImage;
    NSArray *positions;
    UIImage *filterdImage;
}
@property (strong, nonatomic) IBOutlet UIImageView *displayImage;
@property(retain, nonatomic) NSArray *position;
@property (strong, nonatomic)UIImage *filterdImage;

@end
