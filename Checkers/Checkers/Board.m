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

@synthesize squares ;
@synthesize pieces ;
@synthesize size ;

-(id)initWithSize:(int)newSize{
    if((self = [super init])){
    size = newSize;
        squares =[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setup{
    for (int x =0; x<size; x++){
        for (int i = 0; i<size; i++){
            if (x % 2) {
                if(i % 2){
                    Square *square = [[Square alloc] initWithColor:@"black" Row:i Column:x];
                    [squares addObject:square];
                    if ((x < (size/2.6667))) {
                        square.hasPiece = YES;
                        square.pieceColor = @"white";
                    }
                    if(x > ((size-1)-(size/2.6667))){
                        square.hasPiece = YES;
                        square.pieceColor = @"black";
                    }
                [square release];
                }else{
                    Square *square2 = [[Square alloc] initWithColor:@"white" Row:i Column:x];
                    [squares addObject:square2];
                    [square2 release];
                }

            }else{
                if(i % 2){
                    Square *square2 = [[Square alloc] initWithColor:@"white" Row:i Column:x];
                    [squares addObject:square2];
                    [square2 release];

                }else{
                    Square *square = [[Square alloc] initWithColor:@"black" Row:i Column:x];
                    [squares addObject:square];
                    if ((x < (size/2.6667))) {
                        square.hasPiece = YES;
                        square.pieceColor = @"white";
                    }
                    if(x > ((size-1)-(size/2.6667))){
                        square.hasPiece = YES;
                        square.pieceColor = @"black";
                    }
                    [square release];
                }

            }
        }
    }
    
 }
-(void)addNeighbours{
    for (Square *square in squares){
        if([square.color isEqual: [[NSString alloc]initWithFormat:@"black"]]){
            NSMutableArray *adjecentSquares = [[NSMutableArray alloc] init];
            for (Square *aSquare in squares){
                Square *zSquare =[[Square alloc] initWithColor:@"black" Row:(square.row -1) Column:(square.column -1)];
                Square *xSquare =[[Square alloc] initWithColor:@"black" Row:(square.row -1) Column:(square.column +1)];
                Square *cSquare =[[Square alloc] initWithColor:@"black" Row:(square.row +1) Column:(square.column +1)];
                Square *vSquare =[[Square alloc] initWithColor:@"black" Row:(square.row +1) Column:(square.column -1)];
                if(zSquare.column == aSquare.column && zSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
                if(xSquare.column == aSquare.column && xSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
                if(cSquare.column == aSquare.column && cSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
                if(vSquare.column == aSquare.column && vSquare.row == aSquare.row){
                    [adjecentSquares addObject:aSquare];
                }
            }
            [square addAjacentSquares:adjecentSquares];
            [adjecentSquares release];
        }
    }
}

-(void)draw{
    for (Square *square in squares){
        if ([square.color isEqual:[[NSString alloc] initWithFormat:@"black"]]) {
            printf("[");
            if (square.hasPiece && [square.pieceColor isEqualToString:@"black" ]) {
                printf("X");
            }else if(square.hasPiece && [square.pieceColor isEqualToString:@"white" ]){
                printf("Y");
            }else{
                printf(" ");
            }
            printf("]");
        }else{
            printf("{ }");
        }
        if(square.row == size-1){
            printf("\n");
        }
    [square release];
    }
}

@end
