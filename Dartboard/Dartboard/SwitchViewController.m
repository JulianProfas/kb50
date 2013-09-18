//
//  SwitchViewController.m
//  Dartboard
//
//  Created by HHs on 9/18/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "SwitchViewController.h"
#import "DartboardViewController.h"
#import "SettingsViewController.h"

@interface SwitchViewController ()

@end

@implementation SwitchViewController
@synthesize dartboardViewController;
@synthesize settingsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    DartboardViewController *dartController = [[DartboardViewController alloc] initWithNibName:@"Dartboard" bundle:nil];
    self.dartboardViewController = dartController;
    [self.view insertSubview:dartController.view atIndex:0];
    [dartController release];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)dealloc {
    [settingsViewController release];
    [dartboardViewController release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if(self.dartboardViewController.view.superview == nil)
    {
        self.dartboardViewController = nil;
    }else
    {
        self.settingsViewController = nil;
    }
}

-(void)switchViews:(id)sender
{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if(self.settingsViewController.view.superview == nil)
    {
        if(self.settingsViewController == nil)
        {
            SettingsViewController *settingController = [[SettingsViewController alloc] initWithNibName:@"Settins" bundle:nil];
            self.settingsViewController = settingController;
            [settingController release];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [settingsViewController viewWillAppear:YES];
        [dartboardViewController viewWillDisappear:YES];
        
        [dartboardViewController.view removeFromSuperview];
        [self.view insertSubview:settingsViewController.view atIndex:0];
        [dartboardViewController viewDidDisappear:YES];
        [settingsViewController viewDidAppear:YES];
    }else{
        if(self.dartboardViewController == nil)
        {
            DartboardViewController *dartboardController = [[DartboardViewController alloc] initWithNibName:@"dartboard" bundle:nil];
            self.dartboardViewController = dartboardController;
            [dartboardController release];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        
        [settingsViewController viewWillDisappear:YES];
        [dartboardViewController viewWillAppear:YES];
        
        [settingsViewController.view removeFromSuperview];
        [self.view insertSubview:dartboardViewController.view atIndex:0];
        
        [settingsViewController viewDidDisappear:YES];
        [dartboardViewController viewDidAppear:YES];
    }
    
    [UIView commitAnimations];
}

@end
