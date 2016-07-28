//
//  NSString+RandomString.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RandomString)
+ (instancetype)randomStringWithLength:(int)len;
@end
