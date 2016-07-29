//
//  NSString+RandomString.m
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "NSString+RandomString.h"

@implementation NSString (RandomString)

+ (instancetype)randomStringWithLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        NSInteger idx = arc4random_uniform((u_int32_t) [letters length]);
        [randomString appendFormat: @"%C", [letters characterAtIndex:idx]];
    }
    
    return [NSString stringWithString:randomString];
}

@end
