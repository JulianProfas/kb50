//
//  ViewController.m
//  GridAndTouch
//
//  Created by Robin on 10/16/13.
//  Copyright (c) 2013 Robin. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"

#define GRIDHeight ((int) 40)
#define GRIDWidth ((int) 30)
#define squareWidth ((double) 21.3)
#define squareHeight ((double) 28.4)

@interface ViewController ()
@end

@implementation ViewController

@synthesize gridX;
@synthesize touchMoved;
@synthesize margin;



- (void)viewDidLoad
{
    gridX = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    
    //De y coordinaten in een array zetten
    for(int x = 0; x < GRIDWidth; ++x)
    {
        NSMutableArray *gridY = [[NSMutableArray alloc] init];
        [gridX addObject:gridY];
        for(int y = 0; y < GRIDHeight; ++y)
        {
            Photo *photo = [[Photo alloc] init];
            [gridY addObject:photo];
        }
    }
}

//get the screen width (x)
- (CGFloat) screenSizeX
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenBounds.size.width;
    return screenWidth;
}

//get the screen height (y)
- (CGFloat) screenSizeY
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenBounds.size.height;
    return screenHeight;
}

//get the width of a grid square
- (int) getSquareWidthWithScreenWidth:(CGFloat)screenWidth
{
    return (((int)screenWidth) / GRIDWidth);
}

//get the height of a grid square
- (int) getSquareHeightWithScreenHeight:(CGFloat)screenHeight
{
    return (((int)screenHeight) / GRIDHeight);
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoved = NO;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchMoved = YES;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
   
    //check if the person tabbed or moved
    if(!touchMoved)
    {
        //location of where the player touched the screen
        CGPoint location = [touch locationInView:self.view];
        
        //get the location of the square that the player clicked on
        int chosenSquareX = location.x / squareWidth;
        int chosenSquareY = location.y / squareHeight;
        
        
        NSMutableArray *gridY = [gridX objectAtIndex:chosenSquareX];
        [gridY objectAtIndex:chosenSquareY];
        NSLog(@"%i",chosenSquareX);
        NSLog(@"%i",chosenSquareY);
        
    }
}

- (void) checkMarginsWithChosenX: (int)chosenX chosenY:(int)chosenY
{
    NSMutableArray *marginSquares = [[NSMutableArray alloc] init];
    for(int x = 0; x < GRIDWidth; ++x)
    {
        NSMutableArray *gridY = [gridX objectAtIndex:x];
        for(int y = 0; y < GRIDHeight; ++y)
        {
            if((x > (chosenX-margin) || x < (chosenX+margin)) && (y > (chosenY-margin) || y < (chosenY-margin)))
            {
                [marginSquares addObject:[gridY objectAtIndex:y]];
            }
        }
    }
    //marginSquares gebruiken, in deze array zitten alle squares die binnen de margin vallen (margin wordt geset door easy/medium/hard)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
