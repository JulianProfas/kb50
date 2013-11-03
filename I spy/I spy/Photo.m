//
//  Photo.m
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#include <stdlib.h>
#import "Photo.h"
#import "Color.h"

@implementation Photo
@synthesize colorMatrix;
@synthesize pixelatedImage;
@synthesize allAnswerSets;
@synthesize answerSet;
@synthesize answerColor;
@synthesize capturedImage;
@synthesize allCoordinates;

#define MATRIXWIDTH 40
#define MATRIXHEIGHT 60
#define SQUAREWIDTH 8
#define SQUAREHEIGHT 8

#pragma mark - Initialization Methods

- (id) initWithImage:(UIImage *)image difficulty:(NSString *)difficulty
{
    if ( self = [super init] ) {
        capturedImage = image;
        pixelatedImage = [self pixalateImage:image];
        colorMatrix = [self generateColorMatrix:pixelatedImage];
        allAnswerSets = [self generateAnswerSets:difficulty];
        answerSet = [self selectRandomAnswer:allAnswerSets];
        
        //[self printColors];
        //[self printAnswerSet];
        //[self printAllAnswerSets];
        
        return self;
    } else {
        return nil;
    }
}

#pragma mark - UIColoring Protocol Methods

- (NSMutableArray *) generateColorMatrix: (UIImage *)image
{
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
    
    for(int x = 0; x < MATRIXWIDTH; ++x)
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [matrix addObject:column];
        for(int y = 0; y < MATRIXHEIGHT; ++y)
        {
            double centerXcoordinate = (x * SQUAREWIDTH) + (SQUAREWIDTH / 2);
            double centerYcoordinate = (y * SQUAREHEIGHT) + (SQUAREHEIGHT / 2);
            
            UIColor *pixelColor = [self getPixelColor:image xCoordinate:centerXcoordinate yCoordinate:centerYcoordinate];
            Color *color = [[Color alloc]initWithColor:pixelColor];
            [column addObject:color];
        }
    }
    return matrix;
}

- (UIColor *) getPixelColor: (UIImage *)image xCoordinate:(int)x yCoordinate:(int)y
{
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

- (UIImage *) pixalateImage:(UIImage *)image
{
    GPUImageFilter *selectedFilter = [[GPUImagePixellateFilter alloc] init];
    [(GPUImagePixellateFilter *)selectedFilter setFractionalWidthOfAPixel:0.025f];
    return [selectedFilter imageByFilteringImage:image];
}

- (NSMutableOrderedSet *) generateAnswerSets:(NSString *)difficulty
{
    NSMutableSet *uniqueColors = [[NSMutableSet alloc] init];
    NSMutableOrderedSet *allAnswers = [[NSMutableOrderedSet alloc] init];
    
    for (int x = 0; x<MATRIXWIDTH; x++) {
        for (int y = 0; y<MATRIXHEIGHT; y++) {
            NSString *colorName = [[[colorMatrix objectAtIndex:x] objectAtIndex:y] colorName];
            [uniqueColors addObject:colorName];
        }
    }
    
    if ([uniqueColors containsObject:@"loading..."]) {
        [uniqueColors removeObject: @"loading..."];
    }
    
    if (![uniqueColors count] == 0) {
        for(NSString *color in uniqueColors) {
            allCoordinates = [[NSMutableSet alloc] init];
            
            for (int x = 0; x<MATRIXWIDTH; x++) {
                for (int y = 0; y<MATRIXHEIGHT; y++) {
                    NSMutableSet *aBlob = [[NSMutableSet alloc] init];
                    
                    [self generateColorBlob: color
                                xCoordinate:x
                                yCoordinate:y
                                     matrix:aBlob];
                    
                    if ([difficulty isEqualToString:@"hard"] && aBlob.count > 9) {
                        [allAnswers addObject: aBlob];
                    } else if ([difficulty isEqualToString:@"easy"] && aBlob.count > 25) {
                        [allAnswers addObject: aBlob];
                    }else if (aBlob.count > 16) {   //defaults to normal difficulty
                        [allAnswers addObject: aBlob];
                    }
                }
            }
            [allCoordinates removeAllObjects];
        }
    } else {
        NSLog(@"Picture contains no colors, Please take a more colorful picture");
        return nil;
    }
    
    if ([allAnswers count] > 0) {
        NSLog(@"answers: %lu", (unsigned long)[allAnswers count]);
        return allAnswers;
    } else {
        NSLog(@"Colors aren't big enough to play, Please take a picture of a bigger colored object.");
        return nil;
    }
}

- (NSMutableSet *) selectRandomAnswer: (NSMutableOrderedSet *)answerSets
{
    uint32_t rndm = arc4random_uniform((int)[answerSets count]);
    NSMutableSet *aRandomBlob = [answerSets objectAtIndex:rndm];
    
    CGPoint p = [[aRandomBlob anyObject] CGPointValue];
    Color *color = [[colorMatrix objectAtIndex:p.x] objectAtIndex:p.y];
    
    answerColor = color.colorName;
    
    return aRandomBlob;
}

#pragma mark - Color Blob Methods

- (void) generateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y matrix:(NSMutableSet *)matrix
{
    if (![allCoordinates containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]]) {
     [allCoordinates addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
        if (x > 0 &&
            [color isEqual: [[[colorMatrix objectAtIndex:x-1] objectAtIndex:y] colorName]] &&
            ![matrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x-1, y)]])
        {
            [matrix addObject: [NSValue valueWithCGPoint:CGPointMake(x-1, y)]];
            [self generateColorBlob:color xCoordinate:x-1 yCoordinate:y matrix:matrix];
        }
        
        if (x < MATRIXWIDTH-1 &&
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
        
        if (y < MATRIXHEIGHT-1 &&
            [color isEqual: [[[colorMatrix objectAtIndex:x] objectAtIndex:y+1] colorName]] &&
            ![matrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y+1)]])
        {
            [matrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y+1)]];
            [self generateColorBlob:color xCoordinate:x yCoordinate:y+1 matrix:matrix];
        }
    }
}

#pragma mark - Methods for Debugging

- (void) printColors
{
    NSMutableSet *uniqueColors = [[NSMutableSet alloc] init];
    for (int x = 0; x<MATRIXWIDTH; x++) {
        for (int y = 0; y<MATRIXHEIGHT; y++) {
            [uniqueColors addObject:[[[colorMatrix objectAtIndex:x] objectAtIndex:y] colorName]];
        }
    }
    NSLog(@"Number of colors: %lu", (unsigned long)uniqueColors.count);
    NSLog(@"Colors: %@", uniqueColors);
}

- (void) printAnswerSet
{
    NSLog(@"Printing Answer Set: %@", answerSet);
    NSLog(@"Printing answer count: %lu", (unsigned long)answerSet.count);
}

- (void)printAllAnswerSets
{
    NSLog(@"Printing answerSets (blobs): %@", allAnswerSets);
    NSLog(@"Printing Number of answerSets (blobs) total: %lu", (unsigned long)allAnswerSets.count);
}

@end
