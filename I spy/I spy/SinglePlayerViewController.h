//
//  SinglePlayerViewController.h
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISpyProgressView.h"
#import "UICountingLabel.h"
#import "Game.h"

@protocol SinglePlayerViewControllerDelegate <NSObject>
-(void) SinglePlayerViewControllerDismissed:(NSString *)message round:(int)round score:(int)score time:(int)time;
@end

@interface SinglePlayerViewController : UIViewController
{
    ISpyProgressView *progressBar;
    NSMutableSet *highlighted;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *presentedImage;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic, strong) IBOutlet UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, assign) id <SinglePlayerViewControllerDelegate> singlePlayerViewControllerDelegate;
@property (strong, nonatomic) IBOutlet UIImageView *mainMenu;
@property (nonatomic, weak) NSString *notification;
@property UIImage *myImage;

-(void)highlightAnswer;
-(void)deHighlight;
-(void)closeAnimation;

@end
