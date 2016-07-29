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
@property (nonatomic) InstrumentViewController *viewController;
@end

@implementation InstrumentViewControllerTest

- (void)setUp {
    [super setUp];
    EquityInstrument *instrument = [EquityInstrument equityInstrument];
    self.viewController = [InstrumentViewController instrumentViewControllerWithInstrument:instrument];
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

- (void)testToVerifyProperDisplayOfCurrencyForLabels {
    
    [self.viewController.view traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel *)view;
        }
    }];
}

@end
