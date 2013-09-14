//
//  Move.h
//  Checkers
//
//  Created by Allard Soeters on 13-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Square.h"

@interface Move : NSObject{
    Square *oldSquare;
    Square *newSquare;
    Player *player;
}
@property(nonatomic,retain) Player *player;
@property(nonatomic,retain) Square *oldSquare;
@property(nonatomic,retain) Square *newSquare;

-(id)initWithPlayer:(Player *)aPlayer OldSquare:(Square*)aOldSquare NewSquare:(Square *)aNewSquare;

@end
