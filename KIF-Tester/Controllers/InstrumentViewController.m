//
//  InstrumentViewController.m
//  KIF-Tester
//
//  Created by Jon on 7/27/16.
//  Copyright © 2016 Jon. All rights reserved.
//

#import "InstrumentViewController.h"

@interface InstrumentViewController ()
@property (nonatomic, strong) NSObject <TradableInstrument>* instrument;
@property (nonatomic, strong) UILabel *symbolLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *bidAskLabel;
@end

@implementation InstrumentViewController

NSString *const InstrumentViewControllerAccessibilityLabel = @"Instrument View";

+ (instancetype)instrumentViewControllerWithInstrument:(NSObject <TradableInstrument> *)instrument
{
    return [[self alloc] initWithInstrument:instrument];
}

- (instancetype)initWithInstrument:(id <TradableInstrument>)instrument
{
    self = [super init];
    if (self) {
        _instrument = instrument;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSParameterAssert(self.instrument);
    
    self.view.accessibilityLabel = InstrumentViewControllerAccessibilityLabel;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.symbolLabel = [[UILabel alloc] init];
    self.symbolLabel.font = [UIFont boldSystemFontOfSize:40.0];
    self.symbolLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.symbolLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = [UIFont systemFontOfSize:20.0];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.priceLabel];
    
    self.bidAskLabel = [[UILabel alloc] init];
    self.bidAskLabel.font = [UIFont systemFontOfSize:20.0];
    self.bidAskLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bidAskLabel];
    
    [self setupNavigation];
    [self configureViewConstraints];
    [self updateWithInstrument];
}

- (void)setupNavigation
{
    self.navigationItem.title = @"Instrument Detail";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDoneButton)];
}

- (void)configureViewConstraints
{
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self.symbolLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:padding.left].active = YES;
    [self.symbolLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:padding.right].active = YES;
    [self.symbolLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:padding.top].active = YES;
    
    [self.priceLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:padding.right].active = YES;
    [self.priceLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:padding.right].active = YES;
    [self.priceLabel.topAnchor constraintEqualToAnchor:self.symbolLabel.bottomAnchor constant:20].active = YES;
    
    [self.bidAskLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:padding.right].active = YES;
    [self.bidAskLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:padding.right].active = YES;
    [self.bidAskLabel.topAnchor constraintEqualToAnchor:self.priceLabel.bottomAnchor].active = YES;
}

- (void)updateWithInstrument
{
    self.symbolLabel.text = self.instrument.symbol;
    self.priceLabel.text = [NSString stringWithFormat:@"$%0.2f", (CGFloat)self.instrument.lastTradedPrice / 100.0];

    // Toggle to trigger integration test passing
    BOOL testWillPass = YES;
    
    self.bidAskLabel.text = testWillPass ?
        [NSString stringWithFormat:@"$%0.2f x $%0.2f", (CGFloat)self.instrument.bid / 100.0, (CGFloat)self.instrument.ask / 100.0] :
        [NSString stringWithFormat:@"$%0.2f x $%ld", (CGFloat)self.instrument.bid / 100.0, self.instrument.ask];
}

#pragma mark - Navigation

- (void)didTapDoneButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
