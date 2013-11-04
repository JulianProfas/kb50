//
//  UIView+Bounce.h
//  I spy
//
//  Created by iOS Team on 02/11/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Bounce)
/**
    Animates the bounce effect
 @param bounceFactor 
                How high the screen wil bounce up
*/
- (void)bounce:(float)bounceFactor;

@end