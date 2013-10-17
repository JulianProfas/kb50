//
//  VijandTableViewController.h
//  weekopdracht_4
//
//  Created by justin on 10/8/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VijandTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableDictionary *allEnemies;
@property (nonatomic, strong) NSString *Level;
@property (nonatomic) NSString *filePath;
@property (nonatomic, strong) NSMutableArray *correctEnemies;

@end
