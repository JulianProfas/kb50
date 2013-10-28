//
//  UIColoring.h
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIColoring

- (NSMutableArray *)generateColorMatrix: (UIImage *)image fractionalWidthOfPixel: (float)aFloat;
- (UIColor *)getPixelColor: (UIImage *)image xCoordinate:(int)x yCoordinate:(int)y;

@end
