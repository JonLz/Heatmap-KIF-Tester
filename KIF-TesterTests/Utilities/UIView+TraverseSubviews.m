//
//  UIView+TraverseSubviews.m
//  KIF-Tester
//
//  Created by Jon on 7/28/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "UIView+TraverseSubviews.h"

@implementation UIView (TraverseSubviews)

- (void)traverseSubviewsUsingBlock:(void (^)(UIView *view))block
{
    block(self);
    
    for (UIView *subview in self.subviews)
    {
        [subview traverseSubviewsUsingBlock:block];
    }
}

- (void)traverseSubviewLabelsUsingBlock:(void (^)(UILabel *label))block
{
    [self traverseSubviewsUsingBlock:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            block(label);
        }
    }];
}
@end