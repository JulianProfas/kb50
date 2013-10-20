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
@synthesize colorLabel;

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
    Player *player = [Player sharedManager];
    Game *iSpyWithMyLittleEye = [Game sharedManager];
    
    [iSpyWithMyLittleEye setCurrentPlayer:player];
    
    currentPhoto = [player takePicture];
    
    colorLabel.text = [currentPhoto answerColor];
    
    [iSpyWithMyLittleEye startGame];
}

#pragma mark - IBAction Methods

- (IBAction)toggleImage:(id)sender {
    if (presentedImage.image != [UIImage imageNamed:@"appleLogo.png"]){
        presentedImage.image = [UIImage imageNamed:@"appleLogo.png"];
    } else {
        Photo *aPhoto = [[Photo alloc] init];
        presentedImage.image = [aPhoto generateColorGrid:[UIImage imageNamed:@"appleLogo.png"] fractionalWidthOfPixel:0.025f];
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
        
        CGPoint guessCoordinates = {guessedXcoordinate, guessedYcoordinate};
        NSLog(@"pt: %@", NSStringFromCGPoint(guessCoordinates));
        UIColor *selectedColor = [currentPhoto getPixelColor:[UIImage imageNamed:@"appleLogo.png"] xCoordinate:guessedXcoordinate yCoordinate:guessedYcoordinate];
        //NSLog(@"answerColor")[currentPhoto answerColor];
        NSLog(@"color clicked on: %@", [currentPhoto getColorName:selectedColor]);
        
        [[Game sharedManager] checkAnswer: guessCoordinates];
    }
}

@end
