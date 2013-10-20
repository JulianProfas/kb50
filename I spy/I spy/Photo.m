//
//  Photo.m
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Photo.h"
#include <stdlib.h>

@implementation Photo
@synthesize matrix;
@synthesize filteredImage;
@synthesize answerMatrix;
@synthesize answerColor;

#pragma mark - UIColoring Protocol Methods

//todo: constants!?
- (UIImage *)generateColorGrid: (UIImage *)image fractionalWidthOfPixel: (float)aFloat {
    [self pixalateImage:image];
    
    double MatrixHeight = 1 / aFloat;
    double MatrixWidth = MatrixHeight * 3 / 4;
    
    double squareWidth = 320 / MatrixWidth;
    double squareHeight = 568 / MatrixHeight;
    
    matrix = [[NSMutableArray alloc] init];
    
    for(int x = 0; x < MatrixWidth; ++x)
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [matrix addObject:column];
        for(int y = 0; y < MatrixHeight; ++y)
        {
            double centerXcoordinate = (x * squareWidth) + (squareWidth / 2);
            double centerYcoordinate = (y * squareHeight) + (squareHeight / 2);
            
            UIColor *pixelColor = [self getPixelColor:filteredImage xCoordinate:centerXcoordinate yCoordinate:centerYcoordinate];
            NSString *colorName = [self getColorName:pixelColor];
            
            [column addObject:colorName];
        }
    }
    return filteredImage;
}

-(UIColor *)getPixelColor:(UIImage *)image xCoordinate:(int)x yCoordinate:(int)y{
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

-(NSString *)getColorName:(UIColor *)color{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    //printf("Hue: %f. Saturation: %f. Brightness: %f.",hue,saturation,brightness);
    
    if(hue > 0.5 && hue < 0.7 && saturation > 0.5 && brightness > 0.5){
        return @"Blue";
    } else if(hue > 0.10 && hue < 0.20 && saturation > 0.5 && brightness > 0.75){
        return @"Yellow";
    } else if(hue > 0.99 && hue <= 1 && saturation > 0.5 && brightness > 0.5){
        return @"Red"; //TODO: tweak
    } else if(hue > 0.07 && hue < 0.12 && saturation > 0.75 && brightness > 0.85){
        return @"Orange"; //TODO: tweak
    }else if(hue > 0.7 && hue < 0.85 && saturation > 0.5 && brightness > 0.375){
        return @"Purple"; //TODO: tweak
    }else if(hue > 0.2 && hue < 0.45 && saturation > 0.5 && brightness > 0.25){
        return @"Green";
    }else if(hue >0.05 && hue < 0.12 && saturation > 0.75 && brightness > 0.25 && brightness < 0.63){
        return @"Brown";
    }else if(hue <= 1 && saturation == 0 && brightness > 0.25 && brightness < 0.9){
        return @"Gray"; //TODO: zwart wordt nu als Gray gezien
    }else if (hue <= 1 && saturation == 0 && brightness > 0.9){
        return @"White"; //TODO: wit wordt nu als bruin gezien
    }else if (hue <= 1 && saturation <= 1 && brightness < 0.125){
        return @"Black";
    } else {
        return @"None";
    }
}

#pragma mark - Photo Class Methods

-(void)pixalateImage:(UIImage *)image {
    GPUImageFilter *selectedFilter = [[GPUImagePixellateFilter alloc] init];
    [(GPUImagePixellateFilter *)selectedFilter setFractionalWidthOfAPixel:0.025f];
    filteredImage = [selectedFilter imageByFilteringImage:image];
}

//TODO: Prioritize colors
-(NSMutableOrderedSet *)generateAnswer:(NSString *)difficulty {
    answerMatrix = [[NSMutableOrderedSet alloc] init];
    int randomRow = arc4random() % 30;
    int randomColumn = arc4random() % 40;
    
    NSString *generatedColor = [[matrix objectAtIndex:randomRow] objectAtIndex:randomColumn];
    
    NSLog(@"\nprinting answer coords: %i, %i\n", randomRow, randomColumn);
    NSLog(@"\nprinting answer color: %@\n", generatedColor);
    
    if (![generatedColor isEqualToString:@"None"]) {
        if ([difficulty isEqual: @"easy"]) {        //easy: 120 answers == 10% of the screen
            [self GenerateColorBlob:generatedColor xCoordinate:randomRow yCoordinate:randomColumn];
            if ([answerMatrix count] > 120) {
                answerColor = generatedColor;
                [self printAnswerSet];
                return answerMatrix;
            } else {
                [self generateAnswer:difficulty];
            }
        } else if ([difficulty isEqual:@"hard"]) {  //hard: 30 answers == 2.5% of the screen
            [self GenerateColorBlob:generatedColor xCoordinate:randomRow yCoordinate:randomColumn];
            if ([answerMatrix count] > 30) { //3x3
                answerColor = generatedColor;
                [self printAnswerSet];
                return answerMatrix;
            } else {
                [self generateAnswer:difficulty];
            }
        } else {                                    //medium: 60 answers == 5% of the screen
            [self GenerateColorBlob:generatedColor xCoordinate:randomRow yCoordinate:randomColumn];
            if ([answerMatrix count] > 60) {
                answerColor = generatedColor;
                [self printAnswerSet];
                return answerMatrix;
            } else {
                [self generateAnswer:difficulty];
            }
        }
    } else {
        [self generateAnswer:difficulty];
    }
    
    return answerMatrix;
}

#pragma mark - Color Blob Methods

-(void)GenerateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y {
    
        if (x > 0 && [color isEqual: [[matrix objectAtIndex:x-1] objectAtIndex:y]] && ![answerMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x-1, y)]]) {
            [answerMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x-1, y)]];
            
            [self GenerateColorBlob:color xCoordinate:x-1 yCoordinate:y];
        }
    
        if (x < 29 && [color isEqual: [[matrix objectAtIndex:x+1] objectAtIndex:y]] && ![answerMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x+1, y)]]) {
            [answerMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x+1, y)]];
            
            [self GenerateColorBlob:color xCoordinate:x+1 yCoordinate:y];
        }
    
        if (y > 0 && [color isEqual: [[matrix objectAtIndex:x] objectAtIndex:y-1]] && ![answerMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y-1)]]) {
            [answerMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y-1)]];
            
            [self GenerateColorBlob:color xCoordinate:x yCoordinate:y-1];
        }
    
        if (y < 39 && [color isEqual: [[matrix objectAtIndex:x] objectAtIndex:y+1]] && ![answerMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y+1)]]) {
            [answerMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y+1)]];
            
            [self GenerateColorBlob:color xCoordinate:x yCoordinate:y+1];
        }
}

-(void) printAnswerSet {
    NSLog(@"Printing Answer Set: %@", answerMatrix);
    NSLog(@"Printing answer count: %lu", (unsigned long)answerMatrix.count);
}

@end
