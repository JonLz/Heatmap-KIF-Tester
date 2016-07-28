//
//  EquityInstrument.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "FinancialInstrument.h"
#import "TradableInstrument.h"

@interface EquityInstrument : FinancialInstrument <TradableInstrument>
@property (nonatomic, assign, readonly) NSInteger bid;
@property (nonatomic, assign, readonly) NSInteger ask;
@property (nonatomic, assign, readonly) NSInteger lastTradedPrice;
@property (nonatomic, assign, readonly) NSInteger closingPrice;
@property (nonatomic, assign, readonly) NSInteger openingPrice;
@property (nonatomic, strong, readonly) NSDate *lastTradedAt;
@property (nonatomic, copy, readonly) NSString *exchange;
@property (nonatomic, copy, readonly) NSString *symbol;
@property (nonatomic, assign, readonly) CGFloat percentChange;

// Generates a random equity instrument
+ (instancetype)equityInstrument;

- (instancetype)initWithBid:(NSInteger)bid
                        ask:(NSInteger)ask
               openingPrice:(NSInteger)openingPrice
            lastTradedPrice:(NSInteger)lastTradedPrice
                     symbol:(NSString *)symbol NS_DESIGNATED_INITIALIZER;

@end
