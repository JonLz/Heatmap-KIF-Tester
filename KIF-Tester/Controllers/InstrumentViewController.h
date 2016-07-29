//
//  InstrumentViewController.h
//  KIF-Tester
//
//  Created by Jon on 7/27/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradableInstrument.h"

@interface InstrumentViewController : UIViewController
+ (instancetype)instrumentViewControllerWithInstrument:(NSObject <TradableInstrument> *)instrument;
@end
