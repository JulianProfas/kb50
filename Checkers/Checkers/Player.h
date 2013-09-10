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
}
@property(nonatomic, retain) NSString *color;

-(id)initWithColor:(NSString *)color;
-(void)moveOldSquare:(Square *)nSquare newSquare:(Square *)nNewSquare;
-(void)captureOldSquare:(Square *)nSquare newSquare:(Square *)nNewSquare;
-(void)undo;
-(void)resign;
@end
