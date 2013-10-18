//
//  Player.m
//  TimerProject
//
//  Created by justin on 10/16/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize score;
-(id)initWithScore:(int)_score
{
    self = [super init];
    
    if(self){
        score = _score;
    }
    
    return self;
}
@end
