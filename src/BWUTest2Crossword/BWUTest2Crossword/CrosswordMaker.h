//
//  CrosswordMaker.h
//  BWUTest2Crossword
//
//  Created by Kostya Kolesnyk on 8/5/13.
//  Copyright (c) 2013 Kostya Kolesnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrosswordMaker : NSObject

- (id)initWithWords:(NSArray *)words;
- (NSString *)buildCrossword;

@property (nonatomic) NSArray * words;

@end
