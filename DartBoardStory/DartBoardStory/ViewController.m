//
//  ViewController.m
//  DartBoardStory
//
//  Created by Allard Soeters on 19-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "ViewController.h"
#import "Dartboard.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize settingPicker;
@synthesize settingPickerArray;
@synthesize dificulty;

- (void)viewDidLoad
{
    settingPickerArray = [[NSArray alloc] init];
    NSArray *temp = [[NSArray alloc] initWithObjects:@"Makkelijk",@"Redelijk moeilijk",@"Moeilijk", nil];
    self.settingPickerArray = temp;
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CloseView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [settingPickerArray count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [settingPickerArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    int temp = 0;
    temp = row;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:temp forKey:@"dificulty"];
    [prefs synchronize];
    
    [Dartboard setDificulty:temp];
}

@end
