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

@interface SinglePlayerViewController : UIViewController
{
    ISpyProgressView *progressBar;
    UICountingLabel *scoreLabel;
    UIImage *capturedImage;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *presentedImage;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic, strong) IBOutlet UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIImage *capturedImage;

@end
