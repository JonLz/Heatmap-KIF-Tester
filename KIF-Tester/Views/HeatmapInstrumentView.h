//
//  HeatmapInstrumentView.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TradableInstrument;

@interface HeatmapInstrumentView : UIView
@property (nonatomic, strong, readonly) id <TradableInstrument> instrument;
- (instancetype)initWithInstrument:(id <TradableInstrument>)instrument;
- (void)setInstrument:(id<TradableInstrument>)instrument;
@end
