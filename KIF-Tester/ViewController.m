//
//  ViewController.m
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "ViewController.h"
#import "HeatmapViewModel.h"
#import "HeatmapView.h"
#import "EquityInstrument.h"
#import "TradableInstrument.h"
#import "HeatmapInstrumentView.h"

@interface ViewController () <HeatmapViewDelegate>
@property (nonatomic, strong) NSArray<TradableInstrument> *instruments;
@property (nonatomic, strong) HeatmapView *heatmapView;
@property (nonatomic, strong) HeatmapViewModel *heatmapViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInstruments];
    [self configureHeatmapView];
}

- (void)loadInstruments
{
    NSMutableArray <TradableInstrument> *instruments = [NSMutableArray <TradableInstrument> new];
    for (int i=0;i<35;i++) {
        EquityInstrument *instrument = [EquityInstrument equityInstrument];
        [instruments addObject:instrument];
    }
    self.instruments = [NSArray <TradableInstrument> arrayWithArray:instruments];
}

- (void)configureHeatmapView
{
    self.heatmapViewModel = [[HeatmapViewModel alloc] initWithInstruments:self.instruments];
    self.heatmapView = [[HeatmapView alloc] initWithViewModel:self.heatmapViewModel];
    self.heatmapView.translatesAutoresizingMaskIntoConstraints = NO;
    self.heatmapView.delegate = self;
    
    [self.view addSubview:self.heatmapView];
    [self.heatmapView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.heatmapView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.heatmapView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.heatmapView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

#pragma mark - HeatmapViewDelegate

- (void)heatmapView:(HeatmapView *)view didTapInstrumentView:(HeatmapInstrumentView *)instrumentView
{
    
}
@end
