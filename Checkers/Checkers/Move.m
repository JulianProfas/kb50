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
@synthesize fromSquare;
@synthesize toSquare;

-(id)initWithPlayer:(Player *)aPlayer fromSquare:(Square *)aFromSquare toSquare:(Square *)aToSquare{
    if((self = [super init])){
        self.player = aPlayer;
        self.fromSquare = aFromSquare;
        self.toSquare = aToSquare;
    }
    return self;
    
}

@end
