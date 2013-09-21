//
//  Square.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Square.h"

@implementation Square

@synthesize color;
@synthesize row;
@synthesize column;
@synthesize hasPiece;
@synthesize pieceColor;
@synthesize adjacentSquares;

-(id)initWithColor:(NSString *)aColor Row:(int)aRow Column:(int)aColumn{
    if((self = [super init])){
        self.color = aColor;
        row = aRow;
        column = aColumn;
    }
    return self;
}

-(void)addAdjacentSquares:(NSMutableArray*)squares{
    self.adjacentSquares = squares;
}

@end
