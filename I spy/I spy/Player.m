//
//  Player.m
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "Player.h"
#import "Photo.h"

@implementation Player
@synthesize score;

#pragma mark - Player Singleton Methods

static Player *sharedPlayerManager = nil;

+ (Player*)sharedManager
{
    if (sharedPlayerManager == nil) {
        sharedPlayerManager = [[super allocWithZone:NULL] init];
    }
    return sharedPlayerManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
