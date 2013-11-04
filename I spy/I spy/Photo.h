//
//  Photo.h
//  I spy with my little eye something...
//
//  Created by iOS Team on 10/18/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>
#import "UIColoring.h"

@interface Photo : NSObject <UIColoring>
@property (strong, nonatomic) NSMutableArray *colorMatrix;
@property (strong, nonatomic) NSMutableOrderedSet *allAnswerSets;
@property (strong, nonatomic) NSMutableSet *answerSet;
@property (strong, nonatomic) NSMutableSet *allCoordinates;
@property UIImage *pixelatedImage;
@property NSString *answerColor;
@property UIImage *capturedImage;

#pragma mark - Initialization Methods
/**
    Initialize the photo class with a image and difficulty. 
    @param image
            The image that will be used in this class.
    @param difficulty
            The difficuly wil affect the creations of answer set for this photo.
    @return Returns an instance of this class.
 */
- (id) initWithImage:(UIImage *)image difficulty:(NSString *)difficulty;

#pragma mark - Photo Class Methods
/**
    This methods pixalates the image for further processing such as creatign the answer set, generate colorblob, etc..
    @param image 
            The image that will be pixalated.
    @return Returns the pixalated image.s
 */
- (UIImage *) pixalateImage:(UIImage *)image;
/**
    Generate an answerset bases on the difficulty of the game.
    @param difficulty
            The difficulty of the current game. Based on this difficulty a different answerset will be created. 
    @return Returns a set of answers.s
 */
- (NSMutableOrderedSet *)generateAnswerSets:(NSString *)difficulty;
/**
 This method will return a random answer from an answerset that is created witht he generateAnswersSets method.
 @param answerSets
        The answersets that is created by the generateAnswerSets method.
 @return returns a random answer.
 */
- (NSMutableSet *) selectRandomAnswer: (NSMutableOrderedSet *)answerSets;

#pragma mark - Color Blob Methods
/**
This recursive method generates the color blobs. A color blob is collection of colors that share the same colorname and are neighboors.
 
 @param color
            The readable name of a color.
 @param x   
        The x coordinate of the color in the matrix
 @param y   
        The y coordniate of the color in the matrix
 @param matrix
        The matrix that contains all the colors.
 
 @return Returns a void.
 */
- (void) generateColorBlob:(NSString *)color xCoordinate:(int)x yCoordinate:(int)y matrix:(NSMutableSet *)matrix;

#pragma mark - Methods for Debugging
/**
    This method is used for debugging purposes. It prints all the color names to the output window.
 @return Returns a void.
 */
- (void) printColors;
/**
    This method is usssed for debugging purposes. It prints a answers set.
 @return Returns a void.
 */
- (void) printAnswerSet;
/**
    This method is used for debugging purposes. It prints all answers sets.
    @return Returns a void.
 */
- (void)printAllAnswerSets;

@end
