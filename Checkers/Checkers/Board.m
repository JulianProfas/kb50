//
//  Board.m
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Board.h"

@implementation Board

@synthesize squares = _squares;
@synthesize pieces = _pieces;
@synthesize size = _size;

-(id)initWithSize:(int)newSize{
    if((self = [super init])){
    size = newSize;
    }
    return self;
}

-(void)setup{
    for (int x =0; x<size; x++){
        for (int i = 0; i<size; i++){
            if(i % 2){
                Square *square = [[Square alloc] initWithColor:@"black" Row:i Column:x];
                [squares addObject:square];
            }else{
                Square *square2 = [[Square alloc] initWithColor:@"white" Row:i Column:x];
                [squares addObject:square2];
            }
        }
    }
    
}
-(void)draw{
    
}


@end
