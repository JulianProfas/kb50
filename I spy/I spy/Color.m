//
//  Color.m
//  I spy
//
//  Created by iOS Team on 27/10/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Color.h"

@implementation Color
@synthesize colorName;
@synthesize colorData;
@synthesize hsv;

#pragma mark - Initialization Methods

- initWithColor:(UIColor *)aColor
{
    if ( self = [super init] ) {
        colorData = aColor;
        colorName = [self getColorName:aColor];
        return self;
    } else {
        return nil;
    }
}

#pragma mark - Color Class Methods

- (NSString *)getColorName:(UIColor *)aColor
{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    [aColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    //printf("Hue: %f. Saturation: %f. Brightness: %f.\n", 360 * hue, 100 * saturation, 100 * brightness);
    
    if((hue > 0.51389 && hue < 0.667) && saturation > 0.75 && brightness > 0.75){          //h185-255, s0.5, b3/8
        return @"Blue"; //
    } else if((hue > 0.1389 && hue < 0.167) && saturation > 0.75 && brightness > 0.75){
        return @"Yellow";
    } else if((hue < 0.01389 || hue > 0.9861) && saturation > 0.75 && brightness > 0.75){   //h340-10, s3/4, b1/2
        return @"Red";
    } else if(hue > 0.0694 && hue < 0.083 && saturation > 0.75 && brightness > 0.75){          //h20-40, s0.5, b5/8
        return @"Orange";
    }else if(hue > 0.7083 && hue < 0.83 && saturation > 0.75 && brightness > 0.75){           //h265-280, s0.5, b3/8
        return @"Purple"; //
    }else if(hue > 0.1944 && hue < 0.431 && saturation > 0.75 && brightness > 0.75){             //tweak
        return @"Green";
    }else if(hue > 0.0694 && hue < 0.083 && saturation > 0.75 && (brightness > 0.25 && brightness < 0.60)){
        return @"Brown";
    }else if(hue <= 1 && saturation == 0 && (brightness > 0.25 && brightness < 0.75)){
        return @"Gray";
    }else if (hue <= 1 && saturation == 0 && brightness > 0.95){
        return @"White";
    }else if (hue <= 1 && saturation <= 1 && brightness < 0.05){
        return @"Black";
    } else {
        return @"none";
    }
}

@end
