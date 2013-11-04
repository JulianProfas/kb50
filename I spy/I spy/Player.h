//
//  Player.h
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface Player : NSObject
@property int score;

#pragma mark - Player Singleton Methods
/**
    sharedManager method creates an instance of this class when it hasn't been created before and returns it to the caller
 @return Player Returns the player class
 */
+ (Player*)sharedManager;
/**
    Allocates only one instance of this class
    @return returns an instance of this class
 */
+ (id)allocWithZone:(NSZone *)zone;
/**
    Make a copy of this class
    @return returns this class that has been allocated
 */
- (id)copyWithZone:(NSZone *)zone;

@end
