//
//  Piece.h
//  Checkers
//
//  Created by Julian Profas on 9/11/13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piece : NSObject
{
    NSString *color;
    NSString *rank;
}
@property(nonatomic,retain) NSString *pieceColor;
@property(nonatomic,retain) NSString *rank;
@end
