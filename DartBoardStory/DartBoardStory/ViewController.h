//
//  ViewController.h
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Settings;

@interface ViewController : UIViewController{
    UIPickerView *settingPicker;
    NSArray *settingPickerArray;
    Settings *settings;
}
@property (retain, nonatomic) IBOutlet UIPickerView *settingPicker;
@property (retain, nonatomic) IBOutlet NSArray *settingPickerArray;
@property (retain, nonatomic) Settings *settings;

- (IBAction)CloseView:(id)sender;

@end
