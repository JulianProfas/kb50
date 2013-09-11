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

-(void)moveFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare{
    //remove piece from old location
    fromSquare.hasPiece = NO;
    fromSquare.pieceColor = nil;
    
    //add piece to new location
    toSquare.hasPiece = YES;
    toSquare.pieceColor = fromSquare.pieceColor; //!BUG: momenteel zijn beiden leeg (deze moeten black of white zijn)
    NSLog(@"fromSquare piececolor is %@", fromSquare.pieceColor);
    NSLog(@"toSquare piececolor is %@", toSquare.pieceColor);
    
    //todo: check for multiple captures (combo)
}

-(void)undo{
    
}
-(void)resign{
    
}

@end
