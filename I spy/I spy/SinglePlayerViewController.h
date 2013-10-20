//
//  SinglePlayerViewController.h
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface SinglePlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *presentedImage;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic) Photo *currentPhoto;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

#pragma mark - Game related Methods
- (void) setupGame;

#pragma mark - IBAction Methods
- (IBAction)toggleImage:(id)sender;
@end
