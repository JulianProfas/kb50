//
//  ViewController.h
//  customImageDraw
//
//  Created by justin on 11/1/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
{
    UIImageView *imageView;
    UIImage *originalImage;

}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIImage * originalImage;
@property (nonatomic, strong) IBOutlet UIGestureRecognizer *monkeyPan;
-(IBAction)start:(id)sender;
-(IBAction)add:(id)sender;
-(IBAction)handlePan:(UIPanGestureRecognizer *)recongnizer;
@end
