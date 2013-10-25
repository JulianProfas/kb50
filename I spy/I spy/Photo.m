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
@synthesize pixelatedImage;
@synthesize answerMatrix;
@synthesize answerColor;
@synthesize capturedImage;

#pragma mark - Initialization Methods

- (id)initWithImage:(UIImage *)image difficulty:(NSString *)difficulty {
    if ( self = [super init] ) {
        [self pixalateImage:image];
        [self generateColorMatrix:pixelatedImage fractionalWidthOfPixel:0.025f];

        answerMatrix = [[NSMutableOrderedSet alloc] init];
        
        [self generateAnswerMatrix:difficulty];
        capturedImage = image;
        //[self printAnswerSet];
        return self;
    } else {
        return nil;
    }
}

#pragma mark - UIColoring Protocol Methods

//todo: constants!?
- (void)generateColorMatrix: (UIImage *)image fractionalWidthOfPixel: (float)aFloat {
    
    double MatrixHeight = 1 / aFloat;
    double MatrixWidth = MatrixHeight * 3 / 4;
    
    double squareWidth = 320 / MatrixWidth;
    double squareHeight = 480 / MatrixHeight;
    
    matrix = [[NSMutableArray alloc] init];
    
    for(int x = 0; x < MatrixWidth; ++x)
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [matrix addObject:column];
        for(int y = 0; y < MatrixHeight; ++y)
        {
            double centerXcoordinate = (x * squareWidth) + (squareWidth / 2);
            double centerYcoordinate = (y * squareHeight) + (squareHeight / 2);
            
            UIColor *pixelColor = [self getPixelColor:centerXcoordinate yCoordinate:centerYcoordinate];
            NSString *colorName = [self getColorName:pixelColor];
            
            [column addObject:colorName];
        }
    }
}

-(UIColor *)getPixelColor:(int)x yCoordinate:(int)y {
    UIImage *image = pixelatedImage;
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

//TODO: tweak colors
-(NSString *)getColorName:(UIColor *)color{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    //printf("Hue: %f. Saturation: %f. Brightness: %f.",hue,saturation,brightness);
    
    if((hue > 0.51389 && hue < 0.7083) && saturation > 0.5 && brightness > 0.375){          //h185-255, s0.5, b3/8
        return @"Blue"; //
    } else if(hue > 0.10 && hue < 0.20 && saturation > 0.5 && brightness > 0.75){
        return @"Yellow";
    } else if((hue < 0.0278 || hue > 0.94) && saturation > 0.75 && brightness > 0.5){       //h340-10, s3/4, b1/2
        return @"Red";
    } else if(hue > 0.05 && hue < 0.11 && saturation > 0.5 && brightness > 0.625){          //h20-40, s0.5, b5/8
        return @"Orange";
    }else if(hue > 0.7361 && hue < 0.9 && saturation > 0.5 && brightness > 0.28){           //h265-280, s0.5, b3/8
        return @"Purple"; //
    }else if(hue > 0.2 && hue < 0.45 && saturation > 0.5 && brightness > 0.25){             //tweak
        return @"Green";
    }else if(hue >0.05 && hue < 0.12 && saturation > 0.75 && brightness > 0.25 && brightness < 0.63){
        return @"Brown";
    }else if(hue <= 1 && saturation == 0 && brightness > 0.25 && brightness < 0.9){
        return @"Gray";
    }else if (hue <= 1 && saturation == 0 && brightness > 0.9){
        return @"White";
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
    pixelatedImage = [selectedFilter imageByFilteringImage:image];
}

//todo: add prioritization of certain colors?
//todo: tweak blob size & difficulty
-(NSMutableOrderedSet *)generateAnswerMatrix:(NSString *)difficulty {
    NSMutableOrderedSet *allBlueMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allyellowMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allredMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allOrangeMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allpurpleMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allgreenMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allbrownMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allgrayMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allwhiteMatrix = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *allblackMatrix = [[NSMutableOrderedSet alloc] init];
    
    NSMutableSet *uniqueColors = [[NSMutableSet alloc] init];
    for (int x = 0; x<30; x++) {
        for (int y = 0; y<40; y++) {
            [uniqueColors addObject:[[matrix objectAtIndex:x] objectAtIndex:y]];
        }
    }
    
    NSLog(@"Number of colors: %u", uniqueColors.count-1);
    NSLog(@"Colors: %@", uniqueColors);
    
    for (int x = 0; x<30; x++) {
        for (int y = 0; y<40; y++) {
            if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Blue"]) {
                NSMutableSet *blueMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:blueMatrix];
                /*if ([difficulty isEqualToString:@"hard"] && blueMatrix.count > 100) {
                 //[allBlueMatrix addObject: blueMatrix];
                 } else if ([difficulty isEqualToString:@"easy"] && blueMatrix.count > 100) {
                 //[allBlueMatrix addObject: blueMatrix];
                 }else if (blueMatrix.count > 100) { //normal difficulty
                 //[allBlueMatrix addObject: blueMatrix];
                 }*/
                [allBlueMatrix addObject: blueMatrix];
                
            } else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Yellow"]) {
                NSMutableSet *yellowMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:yellowMatrix];
                [allyellowMatrix addObject: yellowMatrix];
                
            } else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Red"]) {
                NSMutableSet *redMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:redMatrix];
                [allredMatrix addObject: redMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Orange"]) {
                NSMutableSet *orangeMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:orangeMatrix];
                [allOrangeMatrix addObject: orangeMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Purple"]) {
                NSMutableSet *purpleMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:purpleMatrix];
                [allpurpleMatrix addObject: purpleMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Green"]) {
                NSMutableSet *greenMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:greenMatrix];
                [allgreenMatrix addObject: greenMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Brown"]) {
                NSMutableSet *brownMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:brownMatrix];
                [allbrownMatrix addObject: brownMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Gray"]) {
                NSMutableSet *grayMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:grayMatrix];
                [allgrayMatrix addObject: grayMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"White"]) {
                NSMutableSet *whiteMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:whiteMatrix];
                [allwhiteMatrix addObject: whiteMatrix];
                
            }else if ([[[matrix objectAtIndex:x] objectAtIndex:y] isEqual: @"Black"]) {
                NSMutableSet *blackMatrix = [[NSMutableSet alloc] init];
                [self generateColorBlob:[[matrix objectAtIndex:x] objectAtIndex:y] xCoordinate:x yCoordinate:y matrix:blackMatrix];
                [allblackMatrix addObject: blackMatrix];
            }
        }
    }
    
    NSLog(@"Number of blue blobs: %lu", (unsigned long)allBlueMatrix.count);
    NSLog(@"Number of yellow blobs: %lu", (unsigned long)allyellowMatrix.count);
    NSLog(@"Number of red blobs: %lu", (unsigned long)allredMatrix.count);
    NSLog(@"Number of orange blobs: %lu", (unsigned long)allOrangeMatrix.count);
    NSLog(@"Number of purple blobs: %lu", (unsigned long)allpurpleMatrix.count);
    NSLog(@"Number of green blobs: %lu", (unsigned long)allgreenMatrix.count);
    NSLog(@"Number of brown blobs: %lu", (unsigned long)allbrownMatrix.count);
    NSLog(@"Number of gray blobs: %lu", (unsigned long)allgrayMatrix.count);
    NSLog(@"Number of white blobs: %lu", (unsigned long)allwhiteMatrix.count);
    NSLog(@"Number of black blobs: %lu", (unsigned long)allblackMatrix.count);
    
    NSOrderedSet *allColorsMatrix = [NSOrderedSet orderedSetWithObjects:allBlueMatrix, allyellowMatrix, allredMatrix, allOrangeMatrix, allpurpleMatrix, allgreenMatrix, allbrownMatrix, allgrayMatrix, allwhiteMatrix, allblackMatrix, nil];
    
    if (uniqueColors.count == 1) {
        answerMatrix = nil;
        answerColor = @"Not Found";
        return nil;
    } else {
        uint32_t rnd = arc4random_uniform((int)[allColorsMatrix count]);
        NSMutableOrderedSet *randomColorMatrix = [allColorsMatrix objectAtIndex:rnd];
        
        switch (rnd) {
            case 0:
                answerColor = @"Blue";
                break;
            case 1:
                answerColor = @"Yellow";
                break;
            case 2:
                answerColor = @"Red";
                break;
            case 3:
                answerColor = @"Orange";
                break;
            case 4:
                answerColor = @"Purple";
                break;
            case 5:
                answerColor = @"Green";
                break;
            case 6:
                answerColor = @"Brown";
                break;
            case 7:
                answerColor = @"Gray";
                break;
            case 8:
                answerColor = @"White";
                break;
            case 9:
                answerColor = @"Black";
                break;
                
            default:
                answerColor = @"Not Found";
                break;
        }
        
        //NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF[SIZE] > 9"]; //TODO: what to do if there's no blobs of > 9
        //[randomObject filterUsingPredicate:pred];
        
        uint32_t rndm = arc4random_uniform((int)[randomColorMatrix count]);
        NSMutableOrderedSet *randomAnswer = [randomColorMatrix objectAtIndex:rndm];
        
        answerMatrix = randomAnswer;
        
        return randomAnswer;
    }
    return nil;
}

#pragma mark - Color Blob Methods

-(void)generateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y matrix:(NSMutableSet *)colorMatrix {
    
        if (x > 0 && [color isEqual: [[matrix objectAtIndex:x-1] objectAtIndex:y]] && ![colorMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x-1, y)]]) {
            [colorMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x-1, y)]];
            
            [self generateColorBlob:color xCoordinate:x-1 yCoordinate:y matrix:colorMatrix];
        }
    
        if (x < 29 && [color isEqual: [[matrix objectAtIndex:x+1] objectAtIndex:y]] && ![colorMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x+1, y)]]) {
            [colorMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x+1, y)]];
            
            [self generateColorBlob:color xCoordinate:x+1 yCoordinate:y matrix:colorMatrix];
        }
    
        if (y > 0 && [color isEqual: [[matrix objectAtIndex:x] objectAtIndex:y-1]] && ![colorMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y-1)]]) {
            [colorMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y-1)]];
            
            [self generateColorBlob:color xCoordinate:x yCoordinate:y-1 matrix:colorMatrix];
        }
    
        if (y < 39 && [color isEqual: [[matrix objectAtIndex:x] objectAtIndex:y+1]] && ![colorMatrix containsObject:[NSValue valueWithCGPoint:CGPointMake(x, y+1)]]) {
            [colorMatrix addObject: [NSValue valueWithCGPoint:CGPointMake(x, y+1)]];
            
            [self generateColorBlob:color xCoordinate:x yCoordinate:y+1 matrix:colorMatrix];
        }
}

-(void) printAnswerSet {
    NSLog(@"Printing Answer Set: %@", answerMatrix);
    NSLog(@"Printing answer count: %lu", (unsigned long)answerMatrix.count);
}

@end
