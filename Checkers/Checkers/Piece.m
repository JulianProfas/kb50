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
-(void)initWithRow:(int)row Column:(int)column{
    [self init];
    self.row = row;
    self.column = column;
}

-(void)promote{
    
}

@end
