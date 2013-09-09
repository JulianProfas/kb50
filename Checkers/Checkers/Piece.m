//
//  Piece.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Piece.h"

@implementation Piece

@synthesize isAlive = _isAlive;
@synthesize rank = _rank;
@synthesize row = _row;
@synthesize column = _column;

+(int)numberOfPieces{
    return 1;
}

-(id)initWithRow:(int)newRow Column:(int)newColumn{
    
    if((self = [super init])){
        
    self.row = newRow;
    self.column = newColumn;
        
    }
    return self;
}

-(void)promote{
    
}

@end
