//
//  Player.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
{
    NSString *color;
}
@property(nonatomic, retain) NSString *color;

-(void)initWithColor:(NSString *)color;
-(void)move;
-(void)capture;
-(void)undo;
-(void)resign;
@end
