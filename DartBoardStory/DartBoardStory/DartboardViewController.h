//
//  DartboardViewController.h
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DartboardViewController : UIViewController{
    UISlider *verticalSlider;
    UISlider *horizontalSlider;
    UIImageView *croshairView;
    UILabel *fireDart;
}

@property (strong, nonatomic) IBOutlet UILabel *fireDart;
@property (retain, nonatomic) IBOutlet UIImageView *croshairView;
@property (retain, nonatomic) IBOutlet UISlider *verticalSlider;
@property (retain, nonatomic) IBOutlet UISlider *horizontalSlider;
- (IBAction)horizontalChange:(id)sender;
- (IBAction)verticalChange:(id)sender;
- (IBAction)fireButtonPressed:(id)sender;
@end
