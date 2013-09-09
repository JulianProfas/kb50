//
//  main.c
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

int main(int argc, const char * argv[])
{
    Game *game =[[Game alloc] init];
    [game setup];
}
