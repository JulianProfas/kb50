//
//  Player.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Player.h"
#import "Move.h"

@implementation Player

@synthesize moveList;
@synthesize color;

-(id)initWithColor:(NSString *)newColor{
    if((self = [super init])){
        self.color = newColor;
        moveList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)init{
    if((self = [super init])){
        moveList = [[NSMutableArray alloc] init];
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
    
    //add move to moveList
    Move *move = [[Move alloc] initWithPlayer:self OldSquare:fromSquare NewSquare:toSquare];
    [moveList addObject:move];
    
    //todo: check for multiple captures (combo)
    
}

-(void)undo{
    Move *move = [moveList objectAtIndex:moveList.count-1];
    move.oldSquare.hasPiece = YES;
    move.oldSquare.pieceColor = move.newSquare.pieceColor;
    
    move.newSquare.hasPiece = NO;
    move.newSquare.pieceColor = nil;
    
    NSString *moveNotifier = [[NSString alloc] initWithFormat:@"\n%@(%d, %d) moved to (%d, %d)\n\n", move.player.color, move.newSquare.row, move.newSquare.column, move.oldSquare.row, move.oldSquare.column];
    
    printf("%s", [moveNotifier UTF8String]);
    [moveNotifier release];
    
    //remove move from movelist
    [moveList removeObject:move];
    
}
-(void)resign{
    
}

@end
