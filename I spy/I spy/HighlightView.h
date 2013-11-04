//
//  HighlightView.h
//  I spy
//
//  Created by iOS Team on 28/10/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighlightView : UIView
/**
    Initailizes the class with a frame
 @param frame   
            the frame of the highligeted area
 @return id
*/
- (id)initWithFrame:(CGRect)frame;
/**
    Generates and draws a rectangle for the highligted area
@param rect
            a rectangle
*/
- (void)drawRect:(CGRect)rect;
@end
