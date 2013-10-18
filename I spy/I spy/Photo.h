//
//  Photo.h
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColoring.h"
#import <GPUImage/GPUImage.h>

@interface Photo : NSObject <UIColoring>
@property (strong, nonatomic) NSMutableArray *matrix;
@property UIImage *filteredImage;

#pragma mark - Photo Class Methods
-(void)pixalateImage:(UIImage *)image;
-(CGPoint)generateAnswer;
@end
