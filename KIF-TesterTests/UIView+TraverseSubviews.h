//
//  UIView+TraverseSubviews.h
//  KIF-Tester
//
//  Created by Jon on 7/28/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TraverseSubviews)
- (void)traverseSubviewsUsingBlock:(void (^)(UIView *view))block;
@end
