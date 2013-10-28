//
//  Color.m
//  I spy
//
//  Created by Julian Profas on 27/10/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Color.h"

@implementation Color
@synthesize colorName;
@synthesize colorData;

#pragma mark - Initialization Methods

- initWithColor:(UIColor *)aColor {
    if ( self = [super init] ) {
        colorData = aColor;
        colorName = [self getColorName:aColor];
        return self;
    } else {
        return nil;
    }
}

//TODO: tweak colors
- (NSString *)getColorName:(UIColor *)aColor{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    [aColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    //printf("Hue: %f. Saturation: %f. Brightness: %f.\n",hue,saturation,brightness);
    
    if((hue > 0.51389 && hue < 0.7083) && saturation > 0.5 && brightness > 0.375){          //h185-255, s0.5, b3/8
        return @"Blue"; //
    } else if((hue > 0.10 && hue < 0.15) && saturation > 0.3 && brightness > 0.25){
        return @"Yellow";
    } else if((hue < 0.08 || hue > 0.94) && (saturation < 0.02 || saturation > 0.24) && brightness > 0.3){   //h340-10, s3/4, b1/2
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
    }else if (hue <= 1 && saturation <= 1 && brightness < 0.1){
        return @"Black";
    } else {
        return @"none";
    }
}
@end
