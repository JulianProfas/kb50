//
//  Photo.m
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Photo.h"
#import "Color.h"
#include <stdlib.h>

@implementation Photo
@synthesize colorMatrix;
@synthesize pixelatedImage;
@synthesize allAnswerSets;
@synthesize answerSet;
@synthesize answerColor;
@synthesize capturedImage;
@synthesize allCoordinates;

#pragma mark - Initialization Methods

- (id) initWithImage:(UIImage *)image difficulty:(NSString *)difficulty {
    if ( self = [super init] ) {
        capturedImage = image;
        pixelatedImage = [self pixalateImage:image];
        colorMatrix = [self generateColorMatrix:pixelatedImage fractionalWidthOfPixel:0.025f];
        //[self printColors];
        
        allAnswerSets = [self generateAnswerSets:difficulty];
        answerSet = [self selectRandomAnswer:allAnswerSets];
        [self printAnswerSet];
        [self printAllAnswerSets];
        
        return self;
    } else {
        return nil;
    }
}

#pragma mark - UIColoring Protocol Methods

- (NSMutableArray *) generateColorMatrix: (UIImage *)image fractionalWidthOfPixel: (float)aFloat {
    
    double MatrixHeight =  60;// 1 / aFloat;
    double MatrixWidth = 40;//MatrixHeight * 3 / 4;
    
    double squareWidth = 8;//image.size.width / MatrixWidth;
    double squareHeight = 8;//image.size.height / MatrixHeight;
    
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
    
    for(int x = 0; x < MatrixWidth; ++x)
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [matrix addObject:column];
        for(int y = 0; y < MatrixHeight; ++y)
        {
            double centerXcoordinate = (x * squareWidth) + (squareWidth / 2);
            double centerYcoordinate = (y * squareHeight) + (squareHeight / 2);
            
            UIColor *pixelColor = [self getPixelColor:image xCoordinate:centerXcoordinate yCoordinate:centerYcoordinate];
            Color *color = [[Color alloc]initWithColor:pixelColor];
            [column addObject:color];
        }
    }
    return matrix;
}

- (UIColor *) getPixelColor: (UIImage *)image xCoordinate:(int)x yCoordinate:(int)y {
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width * y) + x) * 4;
    UInt8 red = data[pixelInfo];
    UInt8 green = data[(pixelInfo + 1)];
    UInt8 blue = data[(pixelInfo + 2)];
    UInt8 alpha = data[(pixelInfo + 3)];
    CFRelease(pixelData);
    
    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
    return color;
}

#pragma mark - Photo Class Methods

- (UIImage *) pixalateImage:(UIImage *)image {
    GPUImageFilter *selectedFilter = [[GPUImagePixellateFilter alloc] init];
    [(GPUImagePixellateFilter *)selectedFilter setFractionalWidthOfAPixel:0.025f];
    return [selectedFilter imageByFilteringImage:image];
}

- (NSMutableOrderedSet *) generateAnswerSets:(NSString *)difficulty {
    NSMutableSet *uniqueColors = [[NSMutableSet alloc] init];
    NSMutableOrderedSet *allAnswers = [[NSMutableOrderedSet alloc] init];
    
    for (int x = 0; x<40; x++) {
        for (int y = 0; y<60; y++) {
            NSString *colorName = [[[colorMatrix objectAtIndex:x] objectAtIndex:y] colorName];
            [uniqueColors addObject:colorName];
        }
    }
    
    if ([uniqueColors containsObject:@"none"]) {
        [uniqueColors removeObject: @"none"];
    }
    
    NSLog(@"Number of colors: %lu", (unsigned long)uniqueColors.count);
    NSLog(@"Colors: %@", uniqueColors);
    
    if (![uniqueColors count] == 0) {
        for(NSString *color in uniqueColors) {
            allCoordinates = [[NSMutableSet alloc] init];
            
            for (int x = 0; x<40; x++) {
                for (int y = 0; y<60; y++) {
                    NSMutableSet *aBlob = [[NSMutableSet alloc] init];
                    
                    [self generateColorBlob: color
                                xCoordinate:x
                                yCoordinate:y
                                     matrix:aBlob];
                    
                    if ([difficulty isEqualToString:@"hard"] && aBlob.count > 10) {
                        [allAnswers addObject: aBlob];
                    } else if ([difficulty isEqualToString:@"easy"] && aBlob.count > 18) {
                        [allAnswers addObject: aBlob];
                    }else if (aBlob.count > 14) {   //defaults to normal difficulty
                        [allAnswers addObject: aBlob];
                    }
                }
            }
            [allCoordinates removeAllObjects];
        }
    } else {
        NSLog(@"contains no colors");
        answerColor = @"No colors found. Please take a more colorful picture";
        return nil;
    }
    
    if ([allAnswers count] > 0) {
        NSLog(@"answers: %d", [allAnswers count]);
        return allAnswers;
    } else {
        answerColor = @"Colors aren't big enough to play, Please take a picture of a bigger colored object.";
        return nil;
    }
}

- (NSMutableSet *) selectRandomAnswer: (NSMutableOrderedSet *)answerSets {
    uint32_t rndm = arc4random_uniform((int)[answerSets count]);
    NSMutableSet *aRandomBlob = [answerSets objectAtIndex:rndm];
    
    CGPoint p = [[aRandomBlob anyObject] CGPointValue];
    Color *color = [[colorMatrix objectAtIndex:p.x] objectAtIndex:p.y];
    
    answerColor = color.colorName;
    
    return aRandomBlob;
}

#pragma mark - Color Blob Methods

- (void) generateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y matrix:(NSMutableSet *)matrix {
    if (![allCoordinates containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]]) {
     [allCoordinates addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
        if (x > 0 &&
            [color isEqual: [[[colorMatrix objectAtIndex:x-1] objectAtIndex:y] colorName]] &&
            ![matrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x-1, y)]])
        {
            [matrix addObject: [NSValue valueWithCGPoint:CGPointMake(x-1, y)]];
            [self generateColorBlob:color xCoordinate:x-1 yCoordinate:y matrix:matrix];
        }
        
        if (x < 39 &&
            [color isEqual: [[[colorMatrix objectAtIndex:x+1] objectAtIndex:y] colorName]] &&
            ![matrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x+1, y)]])
        {
            [matrix addObject: [NSValue valueWithCGPoint:CGPointMake(x+1, y)]];
            [self generateColorBlob:color xCoordinate:x+1 yCoordinate:y matrix:matrix];
        }
        
        if (y > 0 &&
            [color isEqual: [[[colorMatrix objectAtIndex:x] objectAtIndex:y-1] colorName]] &&
            ![matrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y-1)]])
        {
            [matrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y-1)]];
            [self generateColorBlob:color xCoordinate:x yCoordinate:y-1 matrix:matrix];
        }
        
        if (y < 59 &&
            [color isEqual: [[[colorMatrix objectAtIndex:x] objectAtIndex:y+1] colorName]] &&
            ![matrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y+1)]])
        {
            [matrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y+1)]];
            [self generateColorBlob:color xCoordinate:x yCoordinate:y+1 matrix:matrix];
        }
    }
}

#pragma mark - Methods for Debugging

- (void) printColors {
    NSMutableSet *uniqueColors = [[NSMutableSet alloc] init];
    for (int x = 0; x<40; x++) {
        for (int y = 0; y<60; y++) {
                [uniqueColors addObject:[[[colorMatrix objectAtIndex:x] objectAtIndex:y] colorName]];
        }
    }
    
    if ([uniqueColors containsObject:@"none"]) {
        NSLog(@"Number of colors: %lu", (unsigned long)uniqueColors.count-1);
    } else {
        NSLog(@"Number of colors: %lu", (unsigned long)uniqueColors.count);
    }
    
    NSLog(@"Colors: %@", uniqueColors);
}

- (void) printAnswerSet {
    NSLog(@"Printing Answer Set: %@", answerSet);
    NSLog(@"Printing answer count: %lu", (unsigned long)answerSet.count);
}

- (void)printAllAnswerSets {
    NSLog(@"Printing answerSets (blobs): %@", allAnswerSets);
    NSLog(@"Printing Number of answerSets (blobs) total: %lu", (unsigned long)allAnswerSets.count);
}

@end
