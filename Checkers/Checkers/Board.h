//
//  Board.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject
{
    int size;
    NSMutableArray *pieces;
    NSMutableArray *squares;
}
@property(nonatomic) int size;
@property(nonatomic,retain) NSMutableArray *pieces;
@property(nonatomic,retain) NSMutableArray *squares;

-(void)initWithSize:(int)size;
-(void)setup;
-(void)draw;

@end
