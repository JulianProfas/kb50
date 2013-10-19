//
//  SinglePlayerViewController.m
//  I spy with my little eye something...
//
//  Created by Julian Profas on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "Photo.h"
#import "Game.h"

@interface SinglePlayerViewController ()

@end

@implementation SinglePlayerViewController
@synthesize presentedImage;
@synthesize touchMoved;
@synthesize currentPhoto;

#pragma standard iOS Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Game related Methods

- (void) setupGame {
    Game *iSpyWithMyLittleEye = [Game sharedManager];
    
    Player *player = [Player sharedManager];
    [iSpyWithMyLittleEye setCurrentPlayer:player];
    
    currentPhoto = [player takePicture];
    
    [iSpyWithMyLittleEye startGame];
}

#pragma mark - IBAction Methods

- (IBAction)submitGuess:(id)sender {
    Player *player = [Player sharedManager];
    [player submitGuess];
}

- (IBAction)toggleImage:(id)sender {
    if (presentedImage.image != [UIImage imageNamed:@"appleLogo.png"]){
        presentedImage.image = [UIImage imageNamed:@"appleLogo.png"];
    } else {
        Photo *aPhoto = [[Photo alloc] init];
        presentedImage.image = [aPhoto generateColorGrid:[UIImage imageNamed:@"appleLogo.png"] fractionalWidthOfPixel:0.025f gradation:@"normal"];
    }
}

#pragma mark - Touch Methods

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
        int guessedXcoordinate = location.x / 10.7;
        int guessedYcoordinate = location.y / 14.2;
        
        [[currentPhoto.matrix objectAtIndex:guessedXcoordinate] objectAtIndex:guessedYcoordinate];
        
        CGPoint guessCoordinates = {guessedXcoordinate, guessedYcoordinate};
        NSLog(@"pt: %@", NSStringFromCGPoint(guessCoordinates));
        
        [[Game sharedManager] checkAnswer: guessCoordinates];
    }
}

@end
