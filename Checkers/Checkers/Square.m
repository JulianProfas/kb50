//
//  Square.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Square.h"

@implementation Square

@synthesize color = _color;
@synthesize row = _row;
@synthesize column = _column;
@synthesize hasPiece = _hasPiece;
@synthesize adjacentSquares = _adjacentSquares;

+(int)numberOfSquares{
    
    return 1;
}

-(id)initWithColor:(NSString *)newColor Row:(int)newRow Column:(int)newColumn{
    if((self = [super init])){
    self.color = newColor;
    self.row = newRow;
    self.column = newColumn;
    }
    return self;
}

-(id)initWithColor:(NSString *)newColor
{
    if((self = [super init])){
    self.color = newColor;

    }
    return self;
}

@end
