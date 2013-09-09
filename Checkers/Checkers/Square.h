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
    NSArray *adjacentSquares;
}
@property(nonatomic, retain) NSString *color;
@property(nonatomic) int row;
@property(nonatomic) int column;
@property(nonatomic) BOOL hasPiece;
@property(nonatomic, retain) NSArray *adjacentSquares;

+(int)numberOfSquares;
-(id)initWithColor:(NSString *)color Row:(int)row Column:(int)column;
-(id)initWithColor:(NSString *)color;
-(void)addAjacentSquares:(NSMutableArray*)newSquares
@end
