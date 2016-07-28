//
//  HeatmapView.h
//  KIF-Tester
//
//  Created by Jon on 7/26/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeatmapViewModel;

@interface HeatmapView : UIView
- (instancetype)initWithViewModel:(HeatmapViewModel *)viewModel;
@end
