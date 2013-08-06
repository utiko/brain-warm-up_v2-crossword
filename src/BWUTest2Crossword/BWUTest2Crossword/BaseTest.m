//
//  BaseTest.m
//  BWUTest2Crossword
//
//  Created by Kostya Kolesnyk on 8/5/13.
//  Copyright (c) 2013 Kostya Kolesnyk. All rights reserved.
//

#import "BaseTest.h"

@implementation BaseTest

-(id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.testData = @[@[@"NOD",
                        @"BAA",
                        @"YARD",
                        @"AIRWAY",
                        @"NEWTON",
                        @"BURN"],
 
                      @[@"AAA",
                        @"AAA",
                        @"AAAAA",
                        @"AAA",
                        @"AAA",
                        @"AAAAA"],
                      
                      @[@"PTC",
                        @"JYNYFDSGI",
                        @"ZGPPC",
                        @"IXEJNDOP",
                        @"JJFS",
                        @"SSXXQOFGJUZ"],
                      
                      @[@"MPISMEYTWWBYTHA",
                        @"EJHYPZICDDONIUA",
                        @"EJOT",
                        @"YGLLIXXKFPBEPSTKPE",
                        @"EVBIY",
                        @"TNKLLGVGTIKQWUYLLXM"],
                      
                      @[@"ABA",
                        @"CABA",
                        @"DABA",
                        @"CABA",
                        @"GIP",
                        @"TOII"],
                      
                      @[@"NOD",
                        @"BAA",
                        @"YARD",
                        @"AIRWAY",
                        @"NEWWON",
                        @"BURNN"]
                    ];
}

@end
