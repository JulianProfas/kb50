//
//  DartboardViewController.h
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dartboard;
@interface DartboardViewController : UIViewController{
    UISlider *verticalSlider;
    UISlider *horizontalSlider;
    UIImageView *croshairView;
    UIImageView *dartboardView;
    UILabel *fireDart;
    UILabel *lblScore;
    Dartboard *dartboard;
}

@property (retain, nonatomic) IBOutlet UILabel *fireDart;
@property (retain, nonatomic) IBOutlet UILabel *lblScore;
@property (retain, nonatomic) IBOutlet UIImageView *croshairView;
@property (retain, nonatomic) IBOutlet UIImageView *dartboardView;
@property (retain, nonatomic) IBOutlet UISlider *verticalSlider;
@property (retain, nonatomic) IBOutlet UISlider *horizontalSlider;
@property (nonatomic) int dificulty;
@property (nonatomic, retain) Dartboard *dartboard;
- (IBAction)horizontalChange:(id)sender;
- (IBAction)verticalChange:(id)sender;
- (IBAction)fireButtonPressed:(id)sender;
- (void)setupVerticalSlider;
@end
