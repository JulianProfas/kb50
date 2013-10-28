//
//  HighlighView.m
//  Highlight
//
//  Created by justin on 10/28/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "HighlighView.h"

@implementation HighlighView

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
