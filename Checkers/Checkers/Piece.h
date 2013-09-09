//
//  Piece.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piece : NSObject{
    BOOL isAlive;
    NSString *rank;
    int row;
    int column;
}
@property(nonatomic) BOOL isAlive;
@property(nonatomic, retain) NSString *rank;
@property(nonatomic) int row;
@property(nonatomic) int column;

+(int)numberOfPieces;
-(id)initWithRow:(int)row Columm:(int)column;
-(void)promote;

@end
