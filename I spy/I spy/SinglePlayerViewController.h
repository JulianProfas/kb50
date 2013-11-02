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

@interface SinglePlayerViewController : UIViewController
{
    ISpyProgressView *progressBar;
    UICountingLabel *scoreLabel;
    UIImage *capturedImage;
    NSMutableSet *highlighted;
    NSTimer *gameLoopTimer;
    Game *game;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *presentedImage;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic, strong) IBOutlet UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

-(void)highlightAnswer;
-(void)deHighlight;

@end
