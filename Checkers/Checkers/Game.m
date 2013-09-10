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
@synthesize player1Color;
@synthesize player2Color;
@synthesize coordinaatX;
@synthesize coordinaatY;

-(void)setup{
    printf("welke size?\n");
    scanf("%d", &size);
    board = [[Board alloc] initWithSize:size];
    [board setup];
    [board addNeighbours];
    [board draw];
    [self playerChoose];
    [self squareChoose];
    
}

-(void)playerChoose{
    printf("Wie wil je zijn Y of X \n");
    char input[200];
    scanf("%s",input);
    player1Color = [[NSString alloc] initWithUTF8String:input];
    if ([player1Color isEqualToString:@"Y"]) {
        player1Color = @"white";
        player2Color = @"black";
    }else if([player1Color isEqualToString:@"X"]){
        player1Color = @"black";
        player2Color = @"white";
    }else{
        printf("Vul X of Y in en niks anders!\n");
        [self playerChoose];
    }
    player1= [[Player alloc] initWithColor:player1Color];
    player2= [[Player alloc] initWithColor:player2Color];
}

-(void)squareChoose{
    printf("Welk stuk wil je veranderen\n");
    printf("coordinaat X: \n");
    scanf("%d",&coordinaatX);
    printf("coordinaat Y: \n");
    scanf("%d",&coordinaatY);
    Square *square = [board getSquareWithRow:coordinaatX Column:coordinaatY];
    if ([square isEqual:nil] || square.hasPiece != YES ) {
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
    [self squareMoveSquare:square];
}

-(void)squareMoveSquare:(Square *)nSquare{
    Square *newSquare = [board getSquareWithRow:coordinaatX Column:coordinaatY];
    if([newSquare isEqual:nil] ){
        printf("Ongeldig zet. kies opnieuw:\n");
        printf("Welk stuk wil je veranderen\n");
        printf("coordinaat X: \n");
        scanf("%d",&coordinaatX);
        printf("coordinaat Y: \n");
        scanf("%d",&coordinaatY);
        newSquare = [[Square alloc] initWithColor:@"black" Row:coordinaatX Column:coordinaatY];
    }
    if(![self validMoveSquare:newSquare oldSquare:nSquare]){
        [self squareMoveSquare:nSquare];
    }
}

-(BOOL)validMoveSquare:(Square *)newSquare oldSquare:(Square *)nOldSquare{
    if(newSquare.hasPiece == YES && newSquare.pieceColor != player1Color){
        [player1 captureOldSquare:nOldSquare newSquare:newSquare ];
        
        if(newSquare.row > nOldSquare.row && newSquare.column > nOldSquare.column){
            nOldSquare.row = newSquare.row + 1;
            nOldSquare.column = newSquare.column + 1;
            [self validMoveSquare:nOldSquare oldSquare:newSquare];
        }
        if(newSquare.row > nOldSquare.row && newSquare.column < nOldSquare.column){
            nOldSquare.row = newSquare.row + 1;
            nOldSquare.column = newSquare.column - 1;
            [self validMoveSquare:nOldSquare oldSquare:newSquare];
        }
        if(newSquare.row < nOldSquare.row && newSquare.column < nOldSquare.column){
            nOldSquare.row = newSquare.row - 1;
            nOldSquare.column = newSquare.column - 1;
            [self validMoveSquare:nOldSquare oldSquare:newSquare];
        }
        if(newSquare.row < nOldSquare.row && newSquare.column > nOldSquare.column){
            nOldSquare.row = newSquare.row - 1;
            nOldSquare.column = newSquare.column + 1;
            [self validMoveSquare:nOldSquare oldSquare:newSquare];
        }
        [board draw];
        return YES;
    }else if (newSquare.hasPiece == YES && newSquare.pieceColor == player1Color){
        printf("Ongeldig zet het is jouw eigen steen\n");
        [self squareChoose];
    }else{
        [player1 moveOldSquare:nOldSquare newSquare:newSquare];
        [board draw];
        return YES;
    }
    
}
@end
