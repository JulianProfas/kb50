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
@synthesize size;
@synthesize coordinaatX;
@synthesize coordinaatY;
@synthesize currentPlayer;

-(void)setup{
    printf("welke size?\n");
    scanf("%d", &size);
    board = [[Board alloc] initWithSize:size];
    [board setup];
    [board addNeighbours];
    [board draw];
    [self playerChoose];
}

-(void)play{
    if([self squareChoose]){
        if([currentPlayer isEqual:player1]){
            currentPlayer = player2;
        }else{
            currentPlayer = player1;
        }
    [self play];
    }
}

-(void)playerChoose{
    player1 = [[Player alloc] init];
    player2 = [[Player alloc] init];

    printf("Wie wil je zijn Y of X \n");
    char input[200];
    scanf("%s",input);
    player1.color = [[NSString alloc] initWithUTF8String:input];
    if ([player1.color isEqualToString:@"Y"]) {
        player1.color = @"white";
        player2.color = @"black";
    }else if([player1.color isEqualToString:@"X"]){
        player1.color = @"black";
        player2.color = @"white";
    }else{
        printf("Vul X of Y in en niks anders!\n");
        [self playerChoose];
    }
    currentPlayer = player1;
    [self play];
}

-(BOOL)squareChoose{
    printf("Welk stuk wil je veranderen\n");
    printf("coordinaat X: \n");
    scanf("%d",&coordinaatX);
    printf("coordinaat Y: \n");
    scanf("%d",&coordinaatY);
    Square *square = [board getSquareWithRow:coordinaatX Column:coordinaatY];
    if ([square isEqual:nil] || square.hasPiece != YES || square.pieceColor != currentPlayer.color) {
        printf("Ongeldig stuk. of is niet van jou! kies opnieuw:\n");
        printf("Welk stuk wil je veranderen\n");
        printf("coordinaat X: \n");
        scanf("%d",&coordinaatX);
        printf("coordinaat Y: \n");
        scanf("%d",&coordinaatY);
        square = [board getSquareWithRow:coordinaatX Column:coordinaatY];
        [self squareChoose];
    }
    printf("Naar welke coordinaten\n");
    printf("coordinaat X: \n");
    scanf("%d",&coordinaatX);
    printf("coordinaat Y: \n");
    scanf("%d",&coordinaatY);
    if([self squareMoveSquare:square]){
        return  YES;
    }else{
        return NO;
    }
}

-(BOOL)squareMoveSquare:(Square *)nSquare{
    Square *newSquare = [board getSquareWithRow:coordinaatX Column:coordinaatY];
    if(newSquare.column == 0 ){
        printf("Ongeldig zet. kies opnieuw:\n");
        [self squareChoose];
    }
    if(![self validMoveSquare:newSquare oldSquare:nSquare]){
        return NO;
    }
    return YES;
}

-(BOOL)validMoveSquare:(Square *)newSquare oldSquare:(Square *)nOldSquare{
    if((newSquare.column == 0) || (newSquare.hasPiece == YES && newSquare.pieceColor != player1.color)){
        [currentPlayer moveOldSquare:nOldSquare newSquare:newSquare];
        
        if(newSquare.row > nOldSquare.row && newSquare.column > nOldSquare.column){
            int newRow = newSquare.row + 1;
            int newColumn = newSquare.column +1;
            nOldSquare.row = newRow;
            nOldSquare.column = newColumn;
            if([self validMoveSquare:nOldSquare oldSquare:newSquare]){
                return YES;
            }
        }
        if(newSquare.row > nOldSquare.row && newSquare.column < nOldSquare.column){
            int newRow = newSquare.row + 1;
            int newColumn = newSquare.column -1;
            nOldSquare.row = newRow;
            nOldSquare.column = newColumn;
            if([self validMoveSquare:nOldSquare oldSquare:newSquare]){
                return YES;
            }
        }
        if(newSquare.row < nOldSquare.row && newSquare.column < nOldSquare.column){
            int newRow = newSquare.row - 1;
            int newColumn = newSquare.column - 1;
            nOldSquare.row = newRow;
            nOldSquare.column = newColumn;
            if([self validMoveSquare:nOldSquare oldSquare:newSquare]){
                return YES;
            }
        }
        if(newSquare.row < nOldSquare.row && newSquare.column > nOldSquare.column){
            int newRow = newSquare.row - 1;
            int newColumn = newSquare.column +1;
            nOldSquare.row = newRow;
            nOldSquare.column = newColumn;
            if([self validMoveSquare:nOldSquare oldSquare:newSquare]){
                return YES;
            }
        }
        [board draw];
        return YES;
    }else if (newSquare.column == 0 || (newSquare.hasPiece == YES && newSquare.pieceColor == player1.color)){
        printf("Ongeldig zet het is jouw eigen steen\n");
        return NO;
    }else {
        [currentPlayer moveOldSquare:nOldSquare newSquare:newSquare];
        [board draw];
        return YES;
    }
return NO;  
}
@end
