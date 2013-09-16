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

-(void)giveTurnToOtherPlayer{
    if([currentPlayer isEqual:playerOne]){
        currentPlayer = playerTwo;
    }else{
        currentPlayer = playerOne;
    }
}

-(void)nextTurn{
    if ([board checkWinConditions] == kGameRunning) {
        [self giveTurnToOtherPlayer];
        [board draw];
        [self makeMove];
    } else if([board checkWinConditions] == kBlackWon){
        printf("\n\nBlack has won this match!");
    }else{
        printf("\n\nWhite has won this match!");
    }
}

-(void)selectPlayer{
    playerOne = [[Player alloc] init];
    playerTwo = [[Player alloc] init];
    
    printf("Would you like to be black (x) or white (o)? ");
    char input[2];
    scanf("%s",input);
    playerOne.color = [[NSString alloc] initWithUTF8String:input];
    if ([playerOne.color isEqualToString:@"o"]) {
        playerOne.color = @"white";
        playerTwo.color = @"black";
    }else if([playerOne.color isEqualToString:@"x"]){
        playerOne.color = @"black";
        playerTwo.color = @"white";
    }else{
        [self selectPlayer];
    }
    //set first turn to Player 1
    currentPlayer = playerOne;
}

-(void)makeMove{
    printf("%s: Which piece would you like to move?[x-y] or[undo] ", [currentPlayer.color UTF8String]);
    char input[5];
    scanf("%s",input);
    
    NSString *inputString = [[NSString alloc] initWithUTF8String:input];
    if ([inputString rangeOfString:@"-"].location != NSNotFound) {
        NSArray *fromCoordinates = [inputString componentsSeparatedByString:@"-"];
        fromCoordinateX = [fromCoordinates[0] intValue];
        fromCoordinateY = [fromCoordinates[1] intValue];
        
        Square *fromSquare = [board getSquareAtRow: fromCoordinateY Column:fromCoordinateX];
        
        printf("%s: To which coordinates would you like to move? ", [currentPlayer.color UTF8String]);
        char input[5];
        scanf("%s",input);
        
        NSString *inputString = [[NSString alloc] initWithUTF8String:input];
        if ([inputString rangeOfString:@"-"].location != NSNotFound) {
            NSArray *toCoordinates = [inputString componentsSeparatedByString:@"-"];
            toCoordinateX = [toCoordinates[0] intValue];
            toCoordinateY = [toCoordinates[1] intValue];
            
            Square *toSquare = [board getSquareAtRow:toCoordinateY Column:toCoordinateX];
            [self CheckForMoveOrCaptureFromSquare:fromSquare toSquare:toSquare];
        }
    }else {
        if ([[[NSString alloc] initWithUTF8String:input] isEqualToString:@"undo"])
        {
            [self giveTurnToOtherPlayer];
            [currentPlayer undo];
            [board draw];
            [self makeMove];
        }
        
        printf("This coordinate is not valid. please try again\n");
        [self makeMove];
    }
    
    printf("This coordinate is not valid. please try again\n");
    [self makeMove];
}

-(void)CheckForMoveOrCaptureFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare{
    //Check for overlapping squares in neighbors, if so it's a capture
    BOOL captureAllowed = NO;
    for (Square *fromAdjacentSquare in fromSquare.adjacentSquares) {
        for (Square *toAdjacentSquare in toSquare.adjacentSquares) {
            if (fromAdjacentSquare.column == toAdjacentSquare.column &&
                fromAdjacentSquare.row == toAdjacentSquare.row &&
                toSquare.hasPiece == NO) {
                captureAllowed = YES;
            }
        }
    }
    
    //calculate capturedSquare
    Square *capturedSquare = [self calculateCapturedSquare:fromSquare toSquare:toSquare];
    
    //validate the move or capture
    if (captureAllowed && ![self valididateMoveFromSquare:fromSquare toSquare:toSquare]) {
        [currentPlayer captureFromSquare:fromSquare toSquare:toSquare capturedSquare:capturedSquare];
        [self nextTurn];
    } else if ([self valididateMoveFromSquare:fromSquare toSquare:toSquare]) {
        [currentPlayer moveFromSquare:fromSquare toSquare:toSquare];
        [self nextTurn];
    } else {
        printf("%s: [%d-%d] to [%d-%d] is an invalid move.\n", [currentPlayer.color UTF8String], fromSquare.column, fromSquare.row, toSquare.column, toSquare.row);
        [self makeMove];
    }
}

-(Square *)calculateCapturedSquare:(Square *)fromSquare toSquare:(Square*)toSquare{
    int captureRow = 0;
    int captureColumn = 0;
    
    if ([currentPlayer.color isEqual: @"black"]){
        if (fromSquare.row-1 == toSquare.row+1) {       //black can only capture upwards
            captureRow = fromSquare.row-1;
        }
        
        if (fromSquare.column+1 == toSquare.column-1) {
            captureColumn = fromSquare.column+1;
        }
        
        if (fromSquare.column-1 == toSquare.column+1) {
            captureColumn = fromSquare.column-1;
        }
        Square *capturedSquare = [board getSquareAtRow:captureRow Column:captureColumn];
        return capturedSquare;
    } else {
        if (fromSquare.row+1 == toSquare.row-1) {       //white can only capture downwards
            captureRow = fromSquare.row+1;
        }
        
        if (fromSquare.column+1 == toSquare.column-1) {
            captureColumn = fromSquare.column+1;
        }
        
        if (fromSquare.column-1 == toSquare.column+1) {
            captureColumn = fromSquare.column-1;
        }
        Square *capturedSquare = [board getSquareAtRow:captureRow Column:captureColumn];
        return capturedSquare;
    }
    return nil;
}

-(BOOL)valididateMoveFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare{
    
    if ([currentPlayer.color isEqual: @"black"])
    {
        if(fromSquare.row-1 == toSquare.row &&
           (fromSquare.column-1 == toSquare.column || fromSquare.column+1 == toSquare.column) &&
           toSquare.hasPiece == NO)                 //black move code
        {
            return YES;
        } else {
            return NO;
        }
    } else if (fromSquare.row+1 == toSquare.row &&
               (fromSquare.column-1 == toSquare.column || fromSquare.column+1 == toSquare.column) &&
               toSquare.hasPiece == NO)             //white move code
    {
        return YES;
    } else {
        return NO;
    }
}
@end
