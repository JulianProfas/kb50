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

-(void)initWithSize:(int)size{
    [self init];
    self.size = size;
}
-(void)setup{
    for (int tmpSize = self.size; tmpSize<1; tmpSize--){
        if(tmpSize % 2){
        Square *square = [[square alloc] initWithColor:@"black" Row:tmpSize Column:tmpSize];
                          
        }           
    }
    
}
-(void)draw{
    
    
}


@end
