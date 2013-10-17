//
//  ViewController.h
//  GridAndTouch
//
//  Created by Jordi en Robin on 10/16/13.
//  Copyright (c) 2013 Jordi en Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *gridX;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic) int margin;
- (CGFloat) screenSizeX;
- (CGFloat) screenSizeY;
@end


