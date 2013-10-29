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
@property (strong, nonatomic) NSMutableArray *colorMatrix;
@property (strong, nonatomic) NSMutableOrderedSet *allAnswerSets;
@property (strong, nonatomic) NSMutableSet *answerSet;
@property UIImage *pixelatedImage;
@property NSString *answerColor;
@property UIImage *capturedImage;

#pragma mark - Initialization Methods
- (id) initWithImage:(UIImage *)image difficulty:(NSString *)difficulty;

#pragma mark - Photo Class Methods
- (UIImage *) pixalateImage:(UIImage *)image;
- (NSMutableOrderedSet *)generateAnswerSets:(NSString *)difficulty;
- (NSMutableSet *) selectRandomAnswer: (NSMutableOrderedSet *)answerSets;

#pragma mark - Color Blob Methods
- (void) generateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y matrix:(NSMutableSet *)matrix;

#pragma mark - Methods for Debugging
- (void) printColors;
- (void) printAnswerSet;

@end
