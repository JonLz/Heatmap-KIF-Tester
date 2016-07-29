//
//  NSString+CurrencySubstrings.m
//  KIF-Tester
//
//  Created by Jon on 7/28/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "NSString+CurrencySubstrings.h"

@implementation NSString (CurrencySubstrings)
- (NSArray *)currencySubstrings
{
    NSString *anyCurrencyRegexPattern = @"[$][\\d|\\.|,]+";
    NSError *error;
    NSRegularExpression *currencyRegex = [NSRegularExpression regularExpressionWithPattern:anyCurrencyRegexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (error) {
        NSLog(@"Currency regular expression error: %@", error);
        return nil;
    }
    
    NSArray *matches = [currencyRegex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *currencySubstrings = [NSMutableArray new];
    
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [currencySubstrings addObject:[self substringWithRange:obj.range]];
    }];
    
    return [NSArray arrayWithArray:currencySubstrings];
}
@end
