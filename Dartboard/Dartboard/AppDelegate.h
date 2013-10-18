//
//  AppDelegate.h
//  Dartboard
//
//  Created by Allard Soeters on 16-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    SwitchViewController *switchViewController;
}
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SwitchViewController *switchViewController;

@end
