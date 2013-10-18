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

#pragma mark - UIColoring Protocol Methods

- (UIImage *)generateColorGrid: (UIImage *)image fractionalWidthOfPixel: (float)aFloat gradation: (NSString *)aGradation {
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
            [column addObject:[self getColorName:[self getPixelColor:filteredImage xCoordinate:(x*squareWidth) + (squareWidth/2) yCoordinate:(y*squareHeight) + (squareHeight/2)]]];
            
            printf("Color: %s\n", [[self getColorName:[self getPixelColor:filteredImage xCoordinate:(x*squareWidth) + (squareWidth/2) yCoordinate:(y*squareHeight) + (squareHeight/2)]] UTF8String]);
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
        printf("Blue");
    } else if(hue > 0.10 && hue < 0.20 && saturation > 0.5 && brightness > 0.75){
        return @"Yellow";
        printf("Yellow");
    } else if(hue > 0.99 && hue <= 1 && saturation > 0.5 && brightness > 0.5){
        return @"Red";
        printf("Red");
    } else if(hue > 0.07 && hue < 0.12 && saturation > 0.75 && brightness > 0.85){
        return @"Orange";
        printf("Orange");
    }else if(hue > 0.7 && hue < 0.85 && saturation > 0.5 && brightness > 0.375){
        return @"Purple";
        printf("Purple");
    }else if(hue > 0.2 && hue < 0.45 && saturation > 0.5 && brightness > 0.25){
        return @"Green";
        printf("Green");
    }else if(hue >0.05 && hue < 0.12 && saturation > 0.75 && brightness > 0.25 && brightness < 0.63){
        return @"Brown";
        printf("Brown");
    }else if(hue <= 1 && saturation == 0 && brightness > 0.25 && brightness < 0.9){
        return @"Gray";
        printf("Gray");
    }else if (hue <= 1 && saturation == 0 && brightness > 0.9){
        return @"White";
        printf("White");
    }else if (hue <= 1 && saturation <= 1 && brightness < 0.125){
        return @"Black";
        printf("Black");
    } else {
        return @"None";
        printf("None");
    }
}

#pragma mark - Photo Class Methods

-(void)pixalateImage:(UIImage *)image {
    GPUImageFilter *selectedFilter = [[GPUImagePixellateFilter alloc] init];
    [(GPUImagePixellateFilter *)selectedFilter setFractionalWidthOfAPixel:0.025f];
    filteredImage = [selectedFilter imageByFilteringImage:image];
}

-(CGPoint)generateAnswer {
    int randomRow = arc4random() % 30;
    int randomColumn = arc4random() % 40;
    NSLog(@"\nprinting answer coords: %i, %i\n", randomRow, randomColumn);
    NSLog(@"\nprinting answer color: %@\n", [[matrix objectAtIndex:randomRow] objectAtIndex:randomColumn]);
    
    CGPoint answerCoordinates = {randomRow, randomColumn};
    
    return answerCoordinates;
}

@end
