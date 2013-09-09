//
//  Square.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Square.h"

@implementation Square
{
    @synthesize NSString *color;
    @synthesize int row;
    @synthesize int column;
    @synthesize BOOL hasPiece;
    @synthesize NSArray *adjacentSquares;
}
@end
