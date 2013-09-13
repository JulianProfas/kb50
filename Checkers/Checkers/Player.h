//
//  Player.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Square.h"


@interface Player : NSObject
{
    NSString *color;
    NSMutableArray *moveList;
}
@property(nonatomic, retain) NSString *color;
@property(nonatomic,retain) NSMutableArray *moveList;

-(id)initWithColor:(NSString *)color;
-(void)moveFromSquare:(Square *)fromSquare toSquare:(Square *)toSquare;
-(void)undo;
-(void)resign;
-(id)init;
@end
