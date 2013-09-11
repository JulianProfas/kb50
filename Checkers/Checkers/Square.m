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

+(int)numberOfSquares{
    
    return 1;
}

-(id)initWithColor:(NSString *)newColor Row:(int)aRow Column:(int)aColumn{
    if((self = [super init])){
        self.color = newColor;
        row = aRow;
        column = aColumn;
    }
    return self;
}

-(id)initWithColor:(NSString *)aColor
{
    if((self = [super init])){
        self.color = aColor;
        
    }
    return self;
}

-(void)addAjacentSquares:(NSMutableArray*)squares{
    self.adjacentSquares = squares;
}

-(Square *)isNeighboringSquare:(Square*)aSquare{
    for (Square *square in adjacentSquares) {
        if(aSquare.row == square.row && aSquare.column == square.column){
            return square;
        }
    }
    return nil;
}

@end
