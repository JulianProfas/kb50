//
//  WereldTableViewController.h
//  weekopdracht_4
//
//  Created by justin on 10/8/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WereldTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableDictionary *allWorlds;
@property (nonatomic, strong) NSString *game;
@property (nonatomic) NSString *filePath;
@property (nonatomic, strong) NSMutableArray *correctWorlds;

@end
