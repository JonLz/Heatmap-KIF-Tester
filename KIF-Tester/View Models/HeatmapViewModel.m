//
//  Heatmap.m
//  KIF-Tester
//
//  Created by Jon on 7/27/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "HeatmapViewModel.h"
#import "TradableInstrument.h"
#import "HeatmapInstrumentView.h"

@interface HeatmapViewModel ()
@property (nonatomic, strong) NSArray<TradableInstrument> *instruments;
@property (nonatomic, strong) NSMutableArray<HeatmapInstrumentView *> *instrumentViews;
@end

@implementation HeatmapViewModel

- (instancetype)initWithInstruments:(NSArray<TradableInstrument> *)instruments
{
    self = [super init];
    if (self) {
        _instruments = instruments;
        _instrumentViews = [NSMutableArray new];
        [self updateWithInstruments];
    }
    return self;
}

- (void)updateWithInstruments
{
    for (id <TradableInstrument> instrument in self.instruments) {
        [self.instrumentViews addObject:[self viewForInstrument:instrument]];
    }
    
    [self.instrumentViews sortUsingComparator:^NSComparisonResult(HeatmapInstrumentView *a, HeatmapInstrumentView *b) {
        CGFloat first = a.instrument.percentChange;
        CGFloat second = b.instrument.percentChange;
        return first < second;
    }];
}

- (HeatmapInstrumentView *)viewForInstrument:(id <TradableInstrument>)instrument
{
    HeatmapInstrumentView *instrumentView = [[HeatmapInstrumentView alloc] initWithInstrument:instrument];
    instrumentView.backgroundColor = [self backgroundColorForInstrument:instrumentView.instrument];
    return instrumentView;
}

- (UIColor *)backgroundColorForInstrument:(id <TradableInstrument>)instrument
{
    if (instrument.percentChange == 0.0) return [UIColor blackColor];
    return instrument.percentChange > 0 ? [UIColor greenColor] : [UIColor redColor];
}

- (NSInteger)tilesPerRow
{
    return 5;
}

@end
