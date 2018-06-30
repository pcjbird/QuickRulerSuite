//
//  NSString+QuickSportsRulerSeperator.m
//  QuickRulerSuite
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "NSString+QuickSportsRulerSeperator.h"

@implementation NSString (QuickSportsRulerSeperator)

//-------------------------------------------------------
// 1000 => 1,000
// 1000000 => 1,000,000
//-------------------------------------------------------
- (NSString *)quickSportsStringBySeperator:(NSString *)seperator withDistance:(NSInteger)distance
{
    NSString *originString = [self copy];
    
    if ([originString length] < distance) return originString;
    
    NSUInteger start = [originString length] % distance;
    NSString *str = [originString substringWithRange:NSMakeRange(start, originString.length - start)];
    
    NSString *newString = [originString substringWithRange:NSMakeRange(0, start)];
    for (NSUInteger i = 0; i < str.length; i = i + distance)
    {
        NSString *sss = [str substringWithRange:NSMakeRange(i, distance)];
        newString = [newString stringByAppendingString:[NSString stringWithFormat:@"%@%@", seperator, sss]];
    }
    if ([[newString substringWithRange:NSMakeRange(0, 1)] isEqualToString:seperator])
    {
        newString = [newString substringWithRange:NSMakeRange(1, newString.length - 1)];
    }
    return newString;
}

@end
