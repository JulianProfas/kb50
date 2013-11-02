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
- initWithColor:(UIColor *)aColor;

#pragma mark - Color Class Methods
- (NSString *)getColorName:(UIColor *)aColor;
@end
