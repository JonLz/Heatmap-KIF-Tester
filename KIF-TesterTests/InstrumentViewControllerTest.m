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
#import "UIView+TraverseSubviews.h"
#import "EquityInstrument.h"

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
    NSString *anyCurrencyRegexPattern = @"[$][\\d|\\.|,]+";
    NSError *error;
    NSRegularExpression *currencyRegex = [NSRegularExpression regularExpressionWithPattern:anyCurrencyRegexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (error) {
        NSLog(@"Currency regular expression error: %@", error);
    }
    
    NSArray *matches = [currencyRegex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    NSString *validCurrencyRegexPattern = @"[$][\\d|\\.|,]+\\.[\\d]{2}$";
    NSPredicate *validCurrencyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validCurrencyRegexPattern];
    
    for (NSTextCheckingResult *result in matches) {
        NSString *currencyFigure = [text substringWithRange:result.range];
        BOOL validCurrency = [validCurrencyPredicate evaluateWithObject:currencyFigure];
        if (!validCurrency) NSLog(@"Invalid currency detected: %@", currencyFigure);
        XCTAssertTrue(validCurrency);
    }
}

@end
