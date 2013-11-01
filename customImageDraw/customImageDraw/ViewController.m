//
//  ViewController.m
//  customImageDraw
//
//  Created by justin on 11/1/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;
@synthesize originalImage;
@synthesize monkeyPan;

- (void)viewDidLoad
{
    [super viewDidLoad];
    originalImage = [self imageWithImage:[UIImage imageNamed:@"holi-colors_hd.jpg"] scaledToSize:CGSizeMake(320, 400)];
    imageView.image = originalImage;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawImage:(CGRect)rect
{
    int imageViewXPos, imageViewYPos, imageViewWidth, imageViewHeigth;
    imageViewXPos = imageView.frame.origin.x;
    imageViewYPos = imageView.frame.origin.y;
    imageViewWidth = imageView.frame.size.width;
    imageViewHeigth = imageView.frame.size.height;
    
    imageView.frame = CGRectMake(imageViewXPos, imageViewYPos + imageViewHeigth - rect.size.height, rect.size.width, rect.size.height);
    CGImageRef ref = CGImageCreateWithImageInRect(originalImage.CGImage, rect);
    imageView.image = [UIImage imageWithCGImage:ref];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(IBAction)start:(id)sender
{
    int height = 1;
    [self drawImage:CGRectMake(0, originalImage.size.height - height, imageView.image.size.width, height)];
}

-(void)add:(id)sender
{
    int height = imageView.image.size.height + 10;
    [self drawImage:CGRectMake(0, originalImage.size.height - height, imageView.image.size.width, height)];
}

-(void)handlePan:(UIPanGestureRecognizer *)recongnizer
{
    CGPoint translation = [recongnizer translationInView:self.imageView];
    recongnizer.view.center = CGPointMake(recongnizer.view.center.x, recongnizer.view.center.y + translation.y);
    
    [recongnizer setTranslation:CGPointMake(0, 0) inView:self.imageView];
    
    NSLog(@"%f %f", translation.x, translation.y);
}
@end
