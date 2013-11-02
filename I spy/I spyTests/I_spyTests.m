//
//  I_spyTests.m
//  I spyTests
//
//  Created by iOS Team on 10/7/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Photo.h"
#import "Color.h"

@interface I_spyTests : XCTestCase

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
            
            if(y >= (MatrixHeight/2) && x < (MatrixWidth/2)){ //Top Left
                color.colorName = @"Blue";
            }else if(y >= (MatrixHeight/2) && x >= (MatrixWidth/2)){ //Top Right
                color.colorName = @"Red";
            }else if(y < (MatrixHeight/2) && x < (MatrixWidth/2)){ //Bottom Left
                color.colorName = @"Green";
            }else if(y < (MatrixHeight/2) && x >= (MatrixWidth/2)){ //Bottem Right
                color.colorName = @"Yellow";
            }
            
            [column addObject:color];
            
        }
    }
    
    photo.colorMatrix = matrix;
    
    NSMutableOrderedSet *answerSet = [photo generateAnswerSets:@"easy"];
    
    
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
