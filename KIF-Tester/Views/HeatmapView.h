//
//  HeatmapView.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeatmapViewModel;
@class HeatmapInstrumentView;
@class HeatmapView;

@protocol HeatmapViewDelegate <NSObject>
@optional
- (void)heatmapView:(HeatmapView *)view didTapInstrumentView:(HeatmapInstrumentView *)instrumentView;
@end

@interface HeatmapView : UIView
@property (nonatomic, strong, readonly) HeatmapViewModel *viewModel;
@property (nonatomic, weak) id delegate;
- (instancetype)initWithViewModel:(HeatmapViewModel *)viewModel;
- (void)setViewModel:(HeatmapViewModel *)viewModel;
@end
