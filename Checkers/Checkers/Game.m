//
//  Game.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Game.h"
#import "Board.h"

@implementation Game
@synthesize board = _board;
@synthesize player1 = _player1;
@synthesize player2 = _player2;
@synthesize blackPieces = _blackPieces;
@synthesize whitePieces = _whitePieces;
@synthesize turn = _turn;

-(void)setup{
    int size;
    printf("welke size?");
    scanf("%d", &size);
    Board *board = [[Board alloc] initWithSize:size];
    [board setup];
    [board draw];
    
}
@end
