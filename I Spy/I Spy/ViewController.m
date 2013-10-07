//
//  ViewController.m
//  I Spy
//
//  Created by Allard Soeters on 04-10-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize displayImage;
@synthesize filterdImage;

- (void)viewDidLoad
{
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        displayImage.image = image;
        [self PixalateImage:image];
    }
}

-(void)PixalateImage:(UIImage *)imageToFilterd{
    GPUImageFilter *selectedFilter = [[GPUImagePixellateFilter alloc] init];
    [(GPUImagePixellateFilter *)selectedFilter setFractionalWidthOfAPixel:0.05f];
    filterdImage = [selectedFilter imageByFilteringImage:imageToFilterd];
}
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Fout bij opslaan"
                              message: @"De foto is niet opgeslagen"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)ImagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
