//
//  HeatmapInstrumentView.m
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "HeatmapInstrumentView.h"
#import "TradableInstrument.h"

@interface HeatmapInstrumentView ()
@property (nonatomic, strong) id <TradableInstrument> instrument;
@property (nonatomic, strong) UILabel *tickerLabel;
@property (nonatomic, strong) UILabel *percentChangeLabel;
@end

@implementation HeatmapInstrumentView

- (instancetype)initWithInstrument:(id<TradableInstrument>)instrument
{
    self = [super init];
    if (self) {
        _instrument = instrument;
        [self updateWithInstrument:instrument];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self commonInit];
    return self;
}

- (void)commonInit
{
    _tickerLabel = [[UILabel alloc] init];
    _tickerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _tickerLabel.backgroundColor = [UIColor clearColor];
    _tickerLabel.textColor = [UIColor whiteColor];
    _tickerLabel.font = [UIFont boldSystemFontOfSize:28];
    _tickerLabel.textAlignment = NSTextAlignmentLeft;
    _tickerLabel.minimumScaleFactor = 0.7;
    _tickerLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_tickerLabel];
    
    _percentChangeLabel = [[UILabel alloc] init];
    _percentChangeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _percentChangeLabel.backgroundColor = [UIColor clearColor];
    _percentChangeLabel.textColor = [UIColor whiteColor];
    _percentChangeLabel.font = [UIFont boldSystemFontOfSize:20];
    _percentChangeLabel.textAlignment = NSTextAlignmentRight;
    _percentChangeLabel.minimumScaleFactor = 0.7;
    _percentChangeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_percentChangeLabel];

    [self configureTickerLabelConstraints];
    [self configurepercentChangeLabelConstraints];
}

- (void)configureTickerLabelConstraints
{
    [_tickerLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:5].active = YES;
    [_tickerLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:5].active = YES;
    [_tickerLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5].active = YES;
}

- (void)configurepercentChangeLabelConstraints
{
    [_percentChangeLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:5].active = YES;
    [_percentChangeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5].active = YES;
    [_percentChangeLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5].active = YES;
}

- (void)setInstrument:(id<TradableInstrument>)instrument
{
    _instrument = instrument;
    if (instrument) [self updateWithInstrument:instrument];
}

- (void)updateWithInstrument:(id<TradableInstrument>)instrument
{
    self.tickerLabel.text = instrument.symbol;
    self.percentChangeLabel.text = [NSString stringWithFormat:@"%0.2f%%", instrument.percentChange * 100.0];
}
@end
