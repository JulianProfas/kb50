//
//  Game.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Game.h"
#import "Board.h"
#import "Player.h"

#define kGameRunning  0
#define kBlackWon  1
#define kWhitewon  2

@implementation Game
@synthesize board;
@synthesize playerOne;
@synthesize playerTwo;
@synthesize blackPieces;
@synthesize whitePieces;
@synthesize turn;
@synthesize size;
@synthesize fromCoordinateX;
@synthesize fromCoordinateY;
@synthesize toCoordinateX;
@synthesize toCoordinateY;
@synthesize currentPlayer;



-(void)setup{
    printf("Please enter a board size? ");
    scanf("%d", &size);
    board = [[Board alloc] initWithSize:size];
    [board setup];
    [board addNeighboringSquares];
    [board draw];
    [self selectPlayer];
    [self makeMove];
}

-(void)nextTurn{
    [board draw];
    int gameState = [board gameFinished];
    
    if(gameState == kGameRunning){
        if([currentPlayer isEqual:playerOne]){
            currentPlayer = playerTwo;
        }else{
            currentPlayer = playerOne;
        }
        
        [self makeMove];
    }else if(gameState == kBlackWon){
         printf("/n/n Black has won this match! ");
    }else{
         printf("/n/n White has won this match! ");
    }
}

-(void)selectPlayer{
    playerOne = [[Player alloc] init];
    playerTwo = [[Player alloc] init];
    
    printf("Would you like to be black (x) or white (o)? ");
    char input[200];
    scanf("%s",input);
    playerOne.color = [[NSString alloc] initWithUTF8String:input];
    if ([playerOne.color isEqualToString:@"o"]) {
        playerOne.color = @"white";
        playerTwo.color = @"black";
    }else if([playerOne.color isEqualToString:@"x"]){
        playerOne.color = @"black";
        playerTwo.color = @"white";
    }else{
        printf("Please choose black (x) or white (o) ");
        [self selectPlayer];
    }
    //set first turn to Player 1
    currentPlayer = playerOne;
}

-(void)makeMove{
    printf("Which piece would you like to move?\n");
    printf("coordinate X: ");
    scanf("%d",&fromCoordinateX);
    printf("coordinate Y: ");
    scanf("%d",&fromCoordinateY);
    Square *fromSquare = [board getSquareAtRow:fromCoordinateX Column:fromCoordinateY];
    
    /*if ([fromSquare isEqual:nil] || fromSquare.hasPiece != YES || fromSquare.pieceColor != currentPlayer.color) {
     printf("Invalid piece. or not yours! choose again:\n");
     printf("Which piece would you like to move?\n");
     printf("Coordinate X: ");
     scanf("%d",&fromCoordinateX);
     printf("Coordinate Y: ");
     scanf("%d",&fromCoordinateY);
     fromSquare = [board getSquareAtRow:fromCoordinateX Column:fromCoordinateY];
     [self selectSquare];
     }*/
    
    printf("To which coordinates would you like to move?\n");
    printf("coordinate X: ");
    scanf("%d",&toCoordinateX);
    printf("coordinate Y: ");
    scanf("%d",&toCoordinateY);
    Square *toSquare = [board getSquareAtRow:toCoordinateX Column:toCoordinateY];
    
    if([self valididateMoveFromSquare:fromSquare toSquare:toSquare]){
        [currentPlayer moveFromSquare:fromSquare toSquare:toSquare];
        [self nextTurn];
    }
}

-(BOOL)valididateMoveFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare{
    //check for valid moves
    if ([currentPlayer.color isEqual: @"black"])
    {
        if(fromSquare.row < toSquare.row && (fromSquare.column-1 == toSquare.column || fromSquare.column+1 == toSquare.column))
        {
            return YES;
        } else {
            return NO;
        }
    } else if (fromSquare.row > toSquare.row && (fromSquare.column-1 == toSquare.column || fromSquare.column+1 == toSquare.column)) {
        return YES;
    } else {
        return NO;
    }
    //todo: check for valid captures
}

/*
 -(BOOL)valididateMoveFromSquare:(Square *)newSquare toSquare:(Square *)nOldSquare{
 if((newSquare.column == 0) || (newSquare.hasPiece == YES && newSquare.pieceColor != playerOne.color)){
 [currentPlayer moveFromSquare:nOldSquare toSquare:newSquare];
 
 if(newSquare.row > nOldSquare.row && newSquare.column > nOldSquare.column){
 int newRow = newSquare.row + 1;
 int newColumn = newSquare.column +1;
 nOldSquare.row = newRow;
 nOldSquare.column = newColumn;
 if([self valididateMoveFromSquare:nOldSquare toSquare:newSquare]){
 return YES;
 }
 }
 if(newSquare.row > nOldSquare.row && newSquare.column < nOldSquare.column){
 int newRow = newSquare.row + 1;
 int newColumn = newSquare.column -1;
 nOldSquare.row = newRow;
 nOldSquare.column = newColumn;
 if([self valididateMoveFromSquare:nOldSquare toSquare:newSquare]){
 return YES;
 }
 }
 if(newSquare.row < nOldSquare.row && newSquare.column < nOldSquare.column){
 int newRow = newSquare.row - 1;
 int newColumn = newSquare.column - 1;
 nOldSquare.row = newRow;
 nOldSquare.column = newColumn;
 if([self valididateMoveFromSquare:nOldSquare toSquare:newSquare]){
 return YES;
 }
 }
 if(newSquare.row < nOldSquare.row && newSquare.column > nOldSquare.column){
 int newRow = newSquare.row - 1;
 int newColumn = newSquare.column +1;
 nOldSquare.row = newRow;
 nOldSquare.column = newColumn;
 if([self valididateMoveFromSquare:nOldSquare toSquare:newSquare]){
 return YES;
 }
 }
 [board draw];
 return YES;
 }else if (newSquare.column == 0 || (newSquare.hasPiece == YES && newSquare.pieceColor == playerOne.color)){
 printf("Invalid move (Own piece)\n");
 return NO;
 }else {
 [currentPlayer moveFromSquare:nOldSquare toSquare:newSquare];
 [board draw];
 return YES;
 }
 return NO;
 }*/
@end
