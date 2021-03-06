//
//  Square.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Square : NSObject
{
    NSString *color;
    int row;
    int column;
    BOOL hasPiece;
    NSString *pieceColor;
    NSArray *adjacentSquares;
}

@property(nonatomic) int row;
@property(nonatomic) int column;
@property(nonatomic) BOOL hasPiece;
@property(nonatomic, retain) NSString *color;
@property(nonatomic, retain) NSString *pieceColor;
@property(nonatomic, retain) NSArray *adjacentSquares;

-(id)initWithColor:(NSString *)color Row:(int)row Column:(int)column;
-(void)addAdjacentSquares:(NSMutableArray*)squares;
@end
