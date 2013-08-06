//
//  main.m
//  BWUTest2Crossword
//
//  Created by Kostya Kolesnyk on 8/5/13.
//  Copyright (c) 2013 Kostya Kolesnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTest.h"
#import "CrosswordMaker.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int TEST_NUMBER = 3;
        BaseTest * baseTest = [[BaseTest alloc] init];
        NSArray * words = baseTest.testData[TEST_NUMBER];
        CrosswordMaker * crosswordMaker = [[CrosswordMaker alloc] initWithWords: words];
        NSLog(@"\n\nData:\n\n%@\n\nResult:\n\n%@", [words componentsJoinedByString:@"\n"], [crosswordMaker buildCrossword]);
    
    }
    return 0;
}

