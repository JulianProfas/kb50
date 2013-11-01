//
//  I_spyTests.m
//  I spyTests
//
//  Created by Julian Profas on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Photo.h"
#import "Color.h"

@interface I_spyTests : SenTestCase

@end

@implementation I_spyTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGenerateAnswerSets
{
    Photo *photo = [[Photo alloc] init];
    
    //code based on generateColorMatrix from Photo.m
    //used to create the colorMatrix generateAnswerSets requires
    double MatrixHeight = 1 / 0.025f;
    double MatrixWidth = MatrixHeight * 3 / 4;
    
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
    for(int x = 0; x < MatrixWidth; ++x)
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [matrix addObject:column];
        for(int y = 0; y < MatrixHeight; ++y)
        {
            Color *color = [[Color alloc] init];
            
            if(y >= (MatrixHeight/2) && x < (MatrixWidth/2)){ //Bottom Left
                color.colorName = @"Blue";
            }else if(y >= (MatrixHeight/2) && x >= (MatrixWidth/2)){ //Bottom Right
                color.colorName = @"Red";
            }else if(y < (MatrixHeight/2) && x < (MatrixWidth/2)){ //Top Left
                color.colorName = @"Green";
            }else if(y < (MatrixHeight/2) && x >= (MatrixWidth/2)){ //Top Right
                color.colorName = @"Yellow";
            }
            
            [column addObject:color];
            
        }
    }
    
    photo.colorMatrix = matrix;
    
    NSMutableOrderedSet *answerSet = [photo generateAnswerSets:@"easy"];
    
    int count = [answerSet count];
    int correctCount = 4;
    
    //Test #1: Have all objects been added?
    STAssertEquals(count, correctCount, @"There should be 4 items in the answerSet: Blue, Red, Green and Yellow.");
    
    NSMutableSet *green = [answerSet objectAtIndex:0];
    NSMutableSet *blue = [answerSet objectAtIndex:1];
    NSMutableSet *yellow = [answerSet objectAtIndex:2];
    NSMutableSet *red = [answerSet objectAtIndex:3];
    
    NSValue *greenValue = [green anyObject];
    NSValue *blueValue = [blue anyObject];
    NSValue *yellowValue = [yellow anyObject];
    NSValue *redValue = [red anyObject];
    
    CGPoint greenPoint = [greenValue CGPointValue];
    CGPoint bluePoint = [blueValue CGPointValue];
    CGPoint yellowPoint = [yellowValue CGPointValue];
    CGPoint redPoint = [redValue CGPointValue];
    
    Color *greenColor = [[matrix objectAtIndex:greenPoint.x] objectAtIndex:greenPoint.y];
    Color *blueColor = [[matrix objectAtIndex:bluePoint.x] objectAtIndex:bluePoint.y];
    Color *yellowColor = [[matrix objectAtIndex:yellowPoint.x] objectAtIndex:yellowPoint.y];
    Color *redColor = [[matrix objectAtIndex:redPoint.x] objectAtIndex:redPoint.y];
    
    //Test #2: Have the colors been modified?
    STAssertEqualObjects(greenColor.colorName, @"Green", @"Is green correct?");
    STAssertEqualObjects(blueColor.colorName, @"Blue", @"Is blue correct?");
    STAssertEqualObjects(yellowColor.colorName, @"Yellow", @"Is yellow correct?");
    STAssertEqualObjects(redColor.colorName, @"Red", @"Is red correct?");
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
