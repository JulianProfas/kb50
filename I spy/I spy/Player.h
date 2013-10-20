//
//  Player.h
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface Player : NSObject
{
    int score;
    NSMutableOrderedSet *answer;
}
@property int score;
@property NSMutableOrderedSet *answer;

#pragma mark - Player Singleton Methods
+ (Player*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

#pragma mark - Player Class Methods
-(Photo *)takePicture;
-(void)submitGuess;
@end
