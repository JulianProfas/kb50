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
@property (strong, nonatomic) NSMutableSet *answerMatrix;
@property UIImage *pixelatedImage;
@property NSString *answerColor;
@property UIImage *capturedImage;

#pragma mark - Initialization Methods
- (id)initWithImage:(UIImage *)image difficulty:(NSString *)difficulty;

#pragma mark - Photo Class Methods
-(void)pixalateImage:(UIImage *)image;
-(NSMutableSet *)generateAnswerMatrix:(NSString *)difficulty;

#pragma mark - Recursion Methods
-(void)generateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y matrix:(NSMutableSet *)matrix;
-(void) printAnswerSet;
@end
