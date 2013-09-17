//
//  Player.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Player.h"
#import "Square.h"
#import "Board.h"
#import "Move.h"

@implementation Player

@synthesize color;
@synthesize moveList;

-(id)initWithColor:(NSString *)aColor {
    if((self = [super init])){
        self.color = aColor;
    }
    return self;
}

-(id)init{
    if((self = [super init])){
        moveList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)moveFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare {
    //Remove piece from old location
    fromSquare.hasPiece = NO;
    fromSquare.pieceColor = nil;
    
    //Place piece at new location
    toSquare.hasPiece = YES;
    toSquare.pieceColor = self.color;
    
    //prompt user that move is done
    NSString *moveNotifier = [[NSString alloc] initWithFormat:@"\n%@: [%d-%d] moved to [%d-%d]\n\n", toSquare.pieceColor, fromSquare.column, fromSquare.row, toSquare.column, toSquare.row];
    printf("%s", [moveNotifier UTF8String]);
    [moveNotifier release];
    
    //add move to moveList
    Move *move = [[Move alloc] initWithPlayer:self fromSquare:fromSquare toSquare:toSquare];
    [moveList addObject:move];
}

-(void)captureFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare capturedSquare:(Square *)capturedSquare{
    //Remove piece from old location
    fromSquare.hasPiece = NO;
    fromSquare.pieceColor = nil;
    
    //Place piece at new location
    toSquare.hasPiece = YES;
    toSquare.pieceColor = self.color;
    
    //remove captured square from the board
    capturedSquare.hasPiece = NO;
    capturedSquare.pieceColor = nil;
    
    printf("\n%s captured piece at [%d-%d]\n\n", [self.color UTF8String], capturedSquare.column, capturedSquare.row);
}

-(void)undo{
    Move *move = [moveList lastObject];
    move.fromSquare.hasPiece = YES;
    move.fromSquare.pieceColor = move.toSquare.pieceColor;
    
    move.toSquare.hasPiece = NO;
    move.toSquare.pieceColor = nil;
    
    NSString *moveNotifier = [[NSString alloc] initWithFormat:@"\n[UNDO]%@: moved [%d-%d] to [%d-%d]\n\n", move.player.color, move.toSquare.column, move.toSquare.row, move.fromSquare.column, move.fromSquare.row];
    
    printf("%s", [moveNotifier UTF8String]);
    [moveNotifier release];
    
    //remove move from movelist
    [moveList removeLastObject];
}

-(void)resign{
    //remove all pieces from this player
}

@end
