//
//  TradableInstrument.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TradableInstrument <NSObject>
@property (nonatomic, assign, readonly) NSInteger bid;
@property (nonatomic, assign, readonly) NSInteger ask;
@property (nonatomic, assign, readonly) NSInteger lastTradedPrice;
@property (nonatomic, assign, readonly) NSInteger closingPrice;
@property (nonatomic, assign, readonly) NSInteger openingPrice;
@property (nonatomic, strong, readonly) NSDate *lastTradedAt;
@property (nonatomic, copy, readonly) NSString *exchange;
@property (nonatomic, copy, readonly) NSString *symbol;
@property (nonatomic, assign, readonly) CGFloat percentChange;
@end
