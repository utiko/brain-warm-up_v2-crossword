//
//  CrosswordMaker.m
//  BWUTest2Crossword
//
//  Created by Kostya Kolesnyk on 8/5/13.
//  Copyright (c) 2013 Kostya Kolesnyk. All rights reserved.
//

#import "CrosswordMaker.h"



@implementation CrosswordMaker {
    NSMutableArray * completeResults;
    int recIterations;
}

- (id)initWithWords:(NSArray *)words
{
    self = [super init];
    _words = words;
    return self;
}

- (NSString *)buildCrossword
{
    /// Якщо хоч одне слово має менше трьох літер повертаєм false
    for (NSString * word in self.words) {
        if (word.length < 3) return @"false";
    }
    
    completeResults = [NSMutableArray array];
    
    /// Сортування початкового масиву слів по кількості літер
    NSArray *sortedWords;
    sortedWords = [self.words sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString * first = (NSString *) a;
        NSString * second = (NSString *) b;
        return first.length>second.length;
    }];
    
    recIterations = 0;
    /// Запуск рекурсивного методу для перебору можливих варіантів
    [self crosswordMakerProcessWithFreeWords:[NSMutableArray arrayWithArray: sortedWords]
                                     results:[NSMutableArray array]];
    
    //NSLog(@"Results count: %ld", completeResults.count);
    NSLog(@"Rec iterations count: %d", recIterations);

    /// Виведення результату
    if (completeResults.count>0) {
        return [self buildStringGridWithWordList:[completeResults objectAtIndex: 0]];
    }
    else {
        return @"false";
    }
        
    
}




/// words - вільні слова для підстановки
/// results - слова підставлені в правильному порядку
- (void)crosswordMakerProcessWithFreeWords:(NSMutableArray *)words results:(NSMutableArray *)results
{
    recIterations ++;
    if (words.count == 0) {
        /// Якщо не залишилось вільних слів і довжини слів відповідають умові задачі, додаєм отриманий результат в список результатів.
        if ( ((NSString *)results[0]).length + ((NSString *)results[5]).length - 1 == ((NSString *)results[3]).length &&
            ((NSString *)results[1]).length + ((NSString *)results[4]).length - 1 == ((NSString *)results[2]).length)
            [completeResults addObject:results];
    }
    else {
        int i = 0;
        /// Перебір і підстановка вільних слів
        for (NSString * word in words) if (completeResults.count == 0) {
            NSMutableArray * newResults = [results mutableCopy];
            [newResults addObject:word];
            NSMutableArray * newWords = [words mutableCopy];
            [newWords removeObjectAtIndex:i];
            
            /// Пробуєм побудувати кроссворд зі словами на даному рівні рекурсії. Якщо кроссворд можливо побудувати, перходим до наступного рівня.
            NSString * gridString = [self buildStringGridWithWordList:newResults];
            if (gridString)
                [self crosswordMakerProcessWithFreeWords:newWords results:newResults];
            i++;
        }
    }
}


/// Нумерація слів в кросворді

///     2  3
///     |  |
/// 1 - ****
///     *  *   5
///     *  *   |
/// 4 - ********
///        *   *
///        *   *
///        *   *
///    6 - *****


- (NSString *)buildStringGridWithWordList:(NSArray *)wordList
{
    /// Правила розсташування кожного слова для побудови кроссворду
    /// 1-ша цифра: номер слова, кількість літер в якому відповідає координаті X першої літери даного слова. (0 - нульова клітинка)
    /// 2-га цифра: номер слова, кількість літер в якому відповідає координаті Y першої літери даного слова. (0 - нульова клітинка)
    /// Нумерація слів: 1 2 3 4 5 6
    
    /// 3-тя цифра: (0) - по горизонталі, (1) - по вертикалі
    ///
    
    NSArray * rules = @[
                        @[@0, @0, @0],
                        @[@0, @0, @1],
                        @[@1, @0, @1],
                        @[@0, @2, @0],
                        @[@4, @2, @1],
                        @[@1, @3, @0]
                        ];
    /// Наприклад для четвертого слова: 0, 2, 0
    /// Четверте слово починається з клітинки X:0, Y:[довжина 2-го слова]; слово розташоване по горизонталі
    
    NSString * grid[200][200];
    long maxX = 0;
    long maxY = 0;
    
    for (int i=0; i<wordList.count; i++) {
        NSString * word = wordList[i];
        
        /// Визначення координат слова згідно списку
        long x = [rules[i][0] integerValue];
        long y = [rules[i][1] integerValue];
        long direction = [rules[i][2] integerValue];
        if (x>0) x = ((NSString *)wordList[x-1]).length - 1;
        if (y>0) y = ((NSString *)wordList[y-1]).length - 1;
        for (int j=0; j<word.length; j++) {
            
            /// Визначення координати для окремої букви слова
            long curX = x;
            long curY = y;
            if (direction==0) curX+=j;
            if (direction==1) curY+=j;
            
            /// Перевіряєм чи занята клітинка на сітці: додаєм букву або перевіряєм на співпадіння, якщо буква відрізняється повертаєм nil
            if (!grid[curX][curY]) {
                grid[curX][curY] = [word substringWithRange:NSMakeRange(j, 1)];
                if (maxX < curX) maxX = curX;
                if (maxY < curY) maxY = curY;
            }
            else {
                if (![[word substringWithRange:NSMakeRange(j, 1)] isEqual:grid[curX][curY]]) {
                    return nil;
                }
            }
        }
    }
    
    
    /// Перетворення сітки зі словами в string (для подальшого виводу в консоль)
    NSString * result = @"";
    for (int i=0; i<=maxY; i++) {
        for (int j=0; j<=maxX; j++) {
            if (grid[j][i])
                result = [[NSString alloc] initWithFormat:@"%@%@", result, grid[j][i]];
            else
                result = [[NSString alloc] initWithFormat:@"%@.", result];
        }
        result = [[NSString alloc] initWithFormat:@"%@\n", result];
    }
    
    
    return result;
    
    
}




@end
