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

}

-(void)initWithColor:(NSString *)color Row:(int)row Column:(int)column{
    [self init];
    self.color = color;
    self.row = row;
    self.column = column;
}

-(void)initWithColor:(NSString *)color
{
    [self init];
    self.color = color;
}

@end
