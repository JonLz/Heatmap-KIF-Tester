//
//  Heatmap.h
//  KIF-Tester
//
//  Created by Jon on 7/27/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol TradableInstrument;
@class HeatmapInstrumentView;

@interface HeatmapViewModel : NSObject
@property (nonatomic, assign, readonly) NSInteger tilesPerRow;
@property (nonatomic, strong, readonly) NSMutableArray<HeatmapInstrumentView *> *instrumentViews;
- (instancetype)initWithInstruments:(NSArray<TradableInstrument> *)instruments;
@end
