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
+ (Player*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

@end
