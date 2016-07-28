//
//  HeatmapView.m
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "HeatmapView.h"
#import "HeatmapViewModel.h"
#import "HeatmapInstrumentView.h"

@interface HeatmapView ()
@property (nonatomic, strong) HeatmapViewModel *viewModel;
@property (nonatomic, strong) UIStackView *heatmapStackView;
@end

@implementation HeatmapView

- (instancetype)initWithViewModel:(HeatmapViewModel *)viewModel
{
    self = [super init];
    if (self) {
        [self commonInit];
        _viewModel = viewModel;
        [self updateWithViewModel:viewModel];
    }
    return self;
}

- (instancetype)init
{
    self = [self init];
    if (self) {
        [self commonInit];
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
    _heatmapStackView = [[UIStackView alloc] init];
    _heatmapStackView.translatesAutoresizingMaskIntoConstraints = NO;
    _heatmapStackView.axis = UILayoutConstraintAxisVertical;
    _heatmapStackView.spacing = 0;
    _heatmapStackView.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:_heatmapStackView];
    
    [self configureHeatmapStackViewConstraints];
}

- (void)configureHeatmapStackViewConstraints
{
    [self.heatmapStackView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.heatmapStackView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.heatmapStackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.heatmapStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

- (void)updateWithViewModel:(HeatmapViewModel *)viewModel
{
    for (UIView *view in self.heatmapStackView.arrangedSubviews) {
        [self.heatmapStackView removeArrangedSubview:view];
    }
  
    NSInteger tilesPerRow = self.viewModel.tilesPerRow;
    NSInteger totalInstruments = [self.viewModel.instrumentViews count];
    NSInteger totalRows = MAX(1,totalInstruments / tilesPerRow);
    
    for (int i=0; i < totalRows ; i++) {
        
        UIStackView *tileStackView = [[UIStackView alloc] init];
        tileStackView.translatesAutoresizingMaskIntoConstraints = NO;
        tileStackView.axis = UILayoutConstraintAxisHorizontal;
        tileStackView.spacing = 0;
        tileStackView.distribution = UIStackViewDistributionFillEqually;
        [self.heatmapStackView addArrangedSubview:tileStackView];
        
        for (int j=0; j < tilesPerRow ; j++) {
            NSInteger index = i*tilesPerRow + j;
            HeatmapInstrumentView *viewAtIndex = [self.viewModel.instrumentViews objectAtIndex:index];
            [tileStackView addArrangedSubview:viewAtIndex];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([[touch view] isKindOfClass:[HeatmapInstrumentView class]]) {
        HeatmapInstrumentView *view = (HeatmapInstrumentView *)[touch view];
        if ([self.delegate respondsToSelector:@selector(heatmapView:didTapInstrumentView:)]) {
            [self.delegate heatmapView:self didTapInstrumentView:view];
        }
    }
}

@end
