//
//  InstrumentViewControllerTest.m
//  KIF-Tester
//
//  Created by Jon on 7/28/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

#import "InstrumentViewController.h"
#import "EquityInstrument.h"

#import "UIView+TraverseSubviews.h"
#import "NSString+CurrencySubstrings.h"

@interface InstrumentViewControllerTest : KIFTestCase
@property (nonatomic) EquityInstrument *instrument;
@property (nonatomic) InstrumentViewController *viewController;
@end

@implementation InstrumentViewControllerTest

- (void)setUp {
    [super setUp];
    self.instrument = [EquityInstrument equityInstrument];
    self.viewController = [InstrumentViewController instrumentViewControllerWithInstrument:self.instrument];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testToVerifyDisplayAndContentLengthOfLabels {
    
    __block NSInteger labelsFound = 0;
    [self.viewController.view traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            XCTAssert(label.text.length > 0);
            labelsFound += 1;
        }
    }];
    XCTAssert(labelsFound == 3);
}

/*
 *  Old labels would display a dollar amount in actual dollars per the model (e.g. 1000 = $1000)
 *  New labels should display a dollar amount in cents per the model (e.g. 1000 = $10.00)
 */

- (void)testToVerifyProperRepresentationOfCurrencyInCentsForLabels {
    
    [self.viewController.view traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            if ([label.text containsString:@"$"]) {
                [self verifyProperRepresentationOfCurrencyInCents:label.text];
            }
        }
    }];
}

- (void)verifyProperRepresentationOfCurrencyInCents:(NSString *)text
{
    // Checking every possible value here - should be a cleaner way to test but this is exhaustive
    NSArray *validAmounts = @[@(self.instrument.bid), @(self.instrument.ask), @(self.instrument.lastTradedPrice)];
    
    for (NSString *currencyFigure in [text currencySubstrings]) {
        BOOL validCurrencyRepresentation = NO;
        
        for (NSNumber *validAmount in validAmounts) {
            CGFloat validAmountFloat = [validAmount floatValue] / 100.0;
            NSString *validAmountString = [NSString stringWithFormat:@"%0.2f", validAmountFloat];
            validCurrencyRepresentation = [currencyFigure containsString:validAmountString];
            if (validCurrencyRepresentation) break;
        }
        
        XCTAssertTrue(validCurrencyRepresentation);
    }
    
}
- (void)testToVerifyProperDisplayOfCurrencyForLabels {

    [self.viewController.view traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            if ([label.text containsString:@"$"]) {
                [self verifyCurrencyLabelContainsProperDecimalAndSigFigs:label.text];
            }
        }
    }];
}

- (void)verifyCurrencyLabelContainsProperDecimalAndSigFigs:(NSString *)text
{
    NSString *validCurrencyRegexPattern = @"[$][\\d|\\.|,]+\\.[\\d]{2}$";
    NSPredicate *validCurrencyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validCurrencyRegexPattern];
    
    for (NSString *currencyFigure in [text currencySubstrings]) {
        BOOL validCurrency = [validCurrencyPredicate evaluateWithObject:currencyFigure];
        if (!validCurrency) NSLog(@"Invalid currency detected: %@", currencyFigure);
        XCTAssertTrue(validCurrency);
    }
}


@end
