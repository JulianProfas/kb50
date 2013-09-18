//
//  SwitchViewController.h
//  Dartboard
//
//  Created by HHs on 9/18/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;
@class DartboardViewController;

@interface SwitchViewController : UIViewController
{
    SettingsViewController *settingsViewController;
    DartboardViewController *dartboardViewController;
}
@property (retain, nonatomic)SettingsViewController *settingsViewController;
@property (retain, nonatomic)DartboardViewController *dartboardViewController;

-(IBAction)switchViews:(id)sender;

@end
