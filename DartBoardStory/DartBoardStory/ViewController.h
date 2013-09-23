//
//  ViewController.h
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UIPickerView *settingPicker;
    NSArray *settingPickerArray;
    int dificulty;
}
@property (retain, nonatomic) IBOutlet UIPickerView *settingPicker;
@property (retain, nonatomic) IBOutlet NSArray *settingPickerArray;
@property (nonatomic) int dificulty;
- (IBAction)CloseView:(id)sender;

@end
