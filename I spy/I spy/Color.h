//
//  Color.h
//  I spy
//
//  Created by iOS Team on 27/10/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Color : NSObject
@property NSString *colorName;
@property UIColor *colorData;
@property NSString *hsv;

#pragma mark - Initialization Methods
/**
    Initialises the Color class with a given color.
 @param aColor 
            The color of this class
 @return returns a instance of this class.
 */
-(id) initWithColor:(UIColor *)aColor;

#pragma mark - Color Class Methods
/**
    This method returns the color name as a string. For example "blue".
    @param aColor
            The color object that will be used to return a color as a readable text
    @return A string with the color name
 */
- (NSString *)getColorName:(UIColor *)aColor;
@end
