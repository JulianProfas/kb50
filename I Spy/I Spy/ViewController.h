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
    UIImage *filteredImage;
}
@property (strong, nonatomic) IBOutlet UIImageView *filterdImage;
- (IBAction)takePhoto:(id)sender;
- (IBAction)pixalate:(id)sender;

@end
