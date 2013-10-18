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
    Square *fromSquare;
    Square *toSquare;
    Player *player;
}
@property(nonatomic,retain) Player *player;
@property(nonatomic,retain) Square *fromSquare;
@property(nonatomic,retain) Square *toSquare;

-(id)initWithPlayer:(Player *)aPlayer fromSquare:(Square*)aFromSquare toSquare:(Square *)aToSquare;

@end
