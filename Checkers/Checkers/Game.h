//
//  Game.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Player.h"

@interface Game : NSObject{
    Board *board;
    Player *player1;
    Player *player2;
    NSMutableArray *blackPieces;
    NSMutableArray *whitePieces;
    int turn;
    int size;
    int coordinaatX;
    int coordinaatY;
    Player *currentPlayer;

}
@property(nonatomic,retain) Board *board;
@property(nonatomic,retain) Player *player1;
@property(nonatomic,retain) Player *player2;
@property(nonatomic,retain) NSMutableArray *blackPieces;
@property(nonatomic,retain) NSMutableArray *whitePieces;
@property(nonatomic) int turn;
@property(nonatomic) int size;
@property(nonatomic) int coordinaatX;
@property(nonatomic) int coordinaatY;
@property(nonatomic,retain) Player *currentPlayer;

-(void)playPlayer:(Player *)nPlayer;
-(void)setup;
-(void)playerChoose;
-(BOOL)squareChoose;
-(BOOL)squareMoveSquare:(Square *)nSquare;
-(BOOL)validMoveSquare:(Square *)newSquare oldSquare:(Square *)nOldSquare;
@end
