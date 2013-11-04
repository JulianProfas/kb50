//
//  UIColoring.h
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIColoring

/**
    This method generates the color matrix from the image that is given in the parameter. 
 @param image 
            The image that will used for generating the matrix.
 @return Returns a mutable array with colors
 */
- (NSMutableArray *)generateColorMatrix: (UIImage *)image;
/**
    The getPixelColor method returns the color from the given image bases off the x and y coordinate.
 @param image 
            The image that will be used to extract the color from
 @param x
            The x coordinate that will be used to get the position.
 @param y
            The y coordinate that will be used to get the position.
 */
- (UIColor *)getPixelColor: (UIImage *)image xCoordinate:(int)x yCoordinate:(int)y;

@end
