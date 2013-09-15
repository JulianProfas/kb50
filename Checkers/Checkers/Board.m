//
//  Board.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Board.h"
#import "Square.h"

@implementation Board

@synthesize squares;
@synthesize pieces;
@synthesize size;

-(id)initWithSize:(int)aSize{
    if((self = [super init])){
        size = aSize;
        squares =[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setup{
    for (int row = 0; row<size; row++){
        for (int column = 0; column<size; column++){
            if (row % 2) {
                if(column % 2){
                    Square *square = [[Square alloc] initWithColor:@"black" Row:row Column:column];
                    [squares addObject:square];
                    if ((row < (size/2.6667))) {
                        square.hasPiece = YES;
                        square.pieceColor = @"white";
                    }
                    if(row > ((size-1)-(size/2.6667))){
                        square.hasPiece = YES;
                        square.pieceColor = @"black";
                    }
                }else{
                    Square *square2 = [[Square alloc] initWithColor:@"white" Row:row Column:column];
                    [squares addObject:square2];
                }
            }else{
                if(column % 2){
                    Square *square2 = [[Square alloc] initWithColor:@"white" Row:row Column:column];
                    [squares addObject:square2];
                }else{
                    Square *square = [[Square alloc] initWithColor:@"black" Row:row Column:column];
                    [squares addObject:square];
                    if ((row < (size/2.6667))) {
                        square.hasPiece = YES;
                        square.pieceColor = @"white";
                    }
                    if(row > ((size-1)-(size/2.6667))){
                        square.hasPiece = YES;
                        square.pieceColor = @"black";
                    }
                }
                
            }
        }
    }
}
-(void)addNeighboringSquares{
    for (Square *square in squares){
        if([square.color isEqual: [[NSString alloc]initWithFormat:@"black"]]){
            NSMutableArray *adjecentSquares = [[NSMutableArray alloc] init];
            for (Square *aSquare in squares){
                Square *upperLeftSquare =[[Square alloc] initWithColor:@"black" Row:(square.row -1) Column:(square.column -1)];
                Square *upperRightSquare =[[Square alloc] initWithColor:@"black" Row:(square.row -1) Column:(square.column +1)];
                Square *lowerRightSquare =[[Square alloc] initWithColor:@"black" Row:(square.row +1) Column:(square.column +1)];
                Square *lowerLeftSquare =[[Square alloc] initWithColor:@"black" Row:(square.row +1) Column:(square.column -1)];
                if(upperLeftSquare.column == aSquare.column && upperLeftSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
                if(upperRightSquare.column == aSquare.column && upperRightSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
                if(lowerRightSquare.column == aSquare.column && lowerRightSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
                if(lowerLeftSquare.column == aSquare.column && lowerLeftSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
            }
            [square addAjacentSquares:adjecentSquares];
        }
    }
}

-(void)draw{
    printf("\n 0 ");
    for (Square *square in squares){
        if ([square.color isEqual:[[NSString alloc] initWithFormat:@"black"]]) {
            printf("[");
            if (square.hasPiece && [square.pieceColor isEqualToString:@"black"]) {
                printf("x");
            }else if(square.hasPiece && [square.pieceColor isEqualToString:@"white"]){
                printf("o");
            }else{
                printf(" ");
            }
            printf("]");
        }else{
            printf("{ }");
        }
        if(square.column == size - 1 && square.row < size - 1){
            printf("\n %d ",(square.row+1));
        }
    }
    printf("\n    ");
    for(int i = 0; i < size; i++){
        printf("%d  ",i);
    }
    printf("\n\n");
}

-(Square *)getSquareAtRow:(int)aRow Column:(int)aColumn{
    for (int i = 0; i<squares.count;i++){
        Square *square = [squares objectAtIndex:i];
        if ((square.row == aRow) && (square.column == aColumn)) {
            return square;
        }
    }
    return nil;
}

-(int)checkWinConditions{
    BOOL black = NO;
    BOOL white = NO;
    
    for(Square *square in squares){
        if([square.pieceColor isEqualToString:@"black"]){
            black = YES;
        }else if([square.pieceColor isEqualToString:@"white"]){
            white = YES;
        }
        
        if(black && white){
            break;
        }
    }
    
    // 0 : no winners  1 : black won 2 : white won
    if(black && !white){
        return 1;
    }else if(!black && white){
        return 2;
    }
    
    return 0;
}

@end
