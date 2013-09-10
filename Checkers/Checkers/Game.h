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
    Player *playerOne;
    Player *playerTwo;
    NSMutableArray *blackPieces;
    NSMutableArray *whitePieces;
    int turn;
    int size;
    int fromCoordinateX;
    int fromcoordinateY;
    int toCoordinateX;
    int toCoordinateY;
    Player *currentPlayer;

}
@property(nonatomic,retain) Board *board;
@property(nonatomic,retain) Player *playerOne;
@property(nonatomic,retain) Player *playerTwo;
@property(nonatomic,retain) NSMutableArray *blackPieces;
@property(nonatomic,retain) NSMutableArray *whitePieces;
@property(nonatomic) int turn;
@property(nonatomic) int size;
@property(nonatomic) int fromCoordinateX;
@property(nonatomic) int fromCoordinateY;
@property(nonatomic) int toCoordinateX;
@property(nonatomic) int toCoordinateY;
@property(nonatomic,retain) Player *currentPlayer;

-(void)setup;
-(void)selectPlayer;
-(void)nextTurn;
-(void)makeMove;
-(BOOL)valididateMoveFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare;
@end
