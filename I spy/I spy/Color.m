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
    
    if((hue > 0.51389 && hue < 0.7167) && saturation > 0.54 && brightness > 0.25){          //DONE
        return @"Blue"; //
    } else if((hue > 0.1333333 && hue < 0.1666666) && saturation > 0.24 && brightness > 0.20){     //DONE
        return @"Yellow";
    } else if((hue < 0.05278 || hue > 0.91) && saturation > 0.56 && brightness > 0.20){   //DONE
        return @"Red";
    } else if(hue > 0.0694 && hue < 0.083 && saturation > 0.54 && brightness > 0.80){          //DONE
        return @"Orange";
    }else if(hue > 0.7083 && hue < 0.91 && saturation > 0.54 && brightness > 0.54){           //DONE
        return @"Purple"; //
    }else if(hue > 0.1944 && hue < 0.433 && saturation > 0.56 && brightness > 0.25){             //DONE
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
        return @"loading...";
    }
}

@end
