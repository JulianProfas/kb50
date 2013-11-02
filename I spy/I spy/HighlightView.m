//
//  HighlightView.m
//  I spy
//
//  Created by iOS Team on 28/10/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "HighlightView.h"

@implementation HighlightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, self.frame);
    CGContextFillRect(context, self.frame);
}

@end
