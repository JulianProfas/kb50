//
//  Player.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Player.h"
#import "Square.h"

@implementation Player

@synthesize color;

-(id)initWithColor:(NSString *)newColor{
     if((self = [super init])){
    self.color = newColor;
     }
    return self;
}

-(void)moveOldSquare:(Square *)nSquare newSquare:(Square *)nNewSquare{
    nSquare.hasPiece = NO;
    nNewSquare.hasPiece = YES;
    nNewSquare.pieceColor = nSquare.pieceColor;
    nSquare.pieceColor = nil;
}

-(void)captureOldSquare:(Square *)nSquare newSquare:(Square *)nNewSquare{
    nSquare.hasPiece = NO;
    nNewSquare.hasPiece = NO;
    nNewSquare.pieceColor = nSquare.pieceColor;
    nSquare.pieceColor = nil;
    
}

-(void)undo{
    
}
-(void)resign{
    
}

@end
