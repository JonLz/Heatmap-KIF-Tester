//
//  FinancialInstrument.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinancialInstrument : NSObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *longDescription;
@property (nonatomic, copy, readonly) NSString *shortDescription;
@property (nonatomic, copy, readonly) NSString *currency;
@end
