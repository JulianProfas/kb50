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
@synthesize board;
@synthesize player1 ;
@synthesize player2 ;
@synthesize blackPieces ;
@synthesize whitePieces;
@synthesize turn;

-(void)setup{
    int size;
    printf("welke size?");
    scanf("%d", &size);
    board = [[Board alloc] initWithSize:size];
    [board setup];

    [board addNeighbours];
    [board draw];
    
}
@end
