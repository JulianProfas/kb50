//
//  LevelTableViewController.h
//  weekopdracht_4
//
//  Created by justin on 10/8/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableDictionary *allLevels;
@property (nonatomic, strong) NSString *world;
@property (nonatomic) NSString *filePath;
@property (nonatomic, strong) NSMutableArray *correctLevels;

@end
