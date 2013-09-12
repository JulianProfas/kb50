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
    //add piece to new location
    toSquare.hasPiece = YES;
    toSquare.pieceColor = fromSquare.pieceColor;
    
    //remove piece from old location
    fromSquare.hasPiece = NO;
    fromSquare.pieceColor = nil; 
    NSString *moveNotifier = [[NSString alloc] initWithFormat:@"\n%@(%d, %d) moved to (%d, %d)\n\n", toSquare.pieceColor, fromSquare.row, fromSquare.column, toSquare.row, toSquare.column];
    
    printf("%s", [moveNotifier UTF8String]);
    [moveNotifier release];
    
    //todo: check for multiple captures (combo)
    
    
}

-(void)undo{
    
}
-(void)resign{
    
}

@end
