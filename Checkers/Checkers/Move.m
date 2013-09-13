//
//  Move.m
//  Checkers
//
//  Created by Allard Soeters on 13-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import "Move.h"

@implementation Move

@synthesize player;
@synthesize oldSquare;
@synthesize newSquare;

-(id)initWithPlayer:(Player *)aPlayer OldSquare:(Square *)aOldSquare NewSquare:(Square *)aNewSquare{
    if((self = [super init])){
        self.player = aPlayer;
        self.oldSquare = aOldSquare;
        self.newSquare = aNewSquare;
    }
    return self;

}


@end
