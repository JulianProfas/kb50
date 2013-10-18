//
//  Player.h
//  TimerProject
//
//  Created by justin on 10/16/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
{
    int score;
}
@property (nonatomic) int score;
-(id) initWithScore:(int) score;
@end
