//
//  EquityInstrument.m
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "EquityInstrument.h"
#import "NSString+RandomString.h"

@interface EquityInstrument ()
@property (nonatomic, assign) NSInteger bid;
@property (nonatomic, assign) NSInteger ask;
@property (nonatomic, assign) NSInteger lastTradedPrice;
@property (nonatomic, assign) NSInteger closingPrice;
@property (nonatomic, assign) NSInteger openingPrice;
@property (nonatomic, strong) NSDate *lastTradedAt;
@property (nonatomic, copy) NSString *exchange;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, assign) CGFloat percentChange;
@end

@implementation EquityInstrument

+ (instancetype)equityInstrument
{
    return [[self alloc] init];
}

- (instancetype)init
{
    NSInteger bid = arc4random_uniform(10000);
    NSInteger ask = bid + arc4random_uniform(1000);
    NSInteger openingPrice = arc4random_uniform(10000);
    CGFloat percentChange = ((CGFloat)arc4random_uniform(100) + 50)/ 100.0;
    NSInteger ltp = (CGFloat)openingPrice * percentChange;
    NSString *symbol = [[NSString randomStringWithLength:3] uppercaseString];
    return [self initWithBid:bid ask:ask openingPrice:openingPrice lastTradedPrice:ltp symbol:symbol];
}

- (instancetype)initWithBid:(NSInteger)bid
                        ask:(NSInteger)ask
               openingPrice:(NSInteger)openingPrice
            lastTradedPrice:(NSInteger)lastTradedPrice
                     symbol:(NSString *)symbol
{
    self = [super init];
    
    if (self) {
        _bid = bid;
        _ask = ask;
        _openingPrice = openingPrice;
        _lastTradedPrice = lastTradedPrice;
        _symbol = symbol;
    }
    
    return self;
}

- (CGFloat)percentChange
{
    CGFloat changeOnDay = self.lastTradedPrice - self.openingPrice;
    
    if (changeOnDay == 0.0) return 0.0;
    
    CGFloat percentChange = changeOnDay / (CGFloat)self.openingPrice;
    return percentChange;
}
@end
