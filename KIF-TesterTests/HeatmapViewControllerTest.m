//
//  HeatmapViewControllerTest.m
//  KIF-Tester
//
//  Created by Jon on 7/28/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

#import "HeatmapViewController.h"
#import "HeatmapInstrumentView.h"
#import "UIView+TraverseSubviews.h"

extern NSString *const HeatmapViewAccessibilityLabel;
extern NSString *const InstrumentViewControllerAccessibilityLabel;

@interface HeatmapViewControllerTest : KIFTestCase
@property (nonatomic) HeatmapViewController *viewController;
@end

@implementation HeatmapViewControllerTest

- (void)setUp {
    [super setUp];
    self.viewController = [[HeatmapViewController alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testToVerifyHeatmapViewControllerUI {
    [tester waitForViewWithAccessibilityLabel:HeatmapViewAccessibilityLabel];
    [tester tapScreenAtPoint:self.viewController.view.center];
    [tester waitForViewWithAccessibilityLabel:InstrumentViewControllerAccessibilityLabel];
}

- (void)testToVerifyDisplayOfHeatmapView {
    [self.viewController.view traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[HeatmapInstrumentView class]]) {
            HeatmapInstrumentView *instrumentView = (HeatmapInstrumentView *)view;
            [self verifyCountAndContentLengthOfHeatmapInstrumentView:instrumentView];
        }}];
}

- (void)verifyCountAndContentLengthOfHeatmapInstrumentView:(HeatmapInstrumentView *)instrumentView
{
    __block NSInteger labelsFound = 0;
    [instrumentView traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]] ) {
            UILabel *label = (UILabel *)view;
            XCTAssert(label.text.length > 0);
            labelsFound += 1;
        }
    }];
    XCTAssert(labelsFound == 2);
}


@end
