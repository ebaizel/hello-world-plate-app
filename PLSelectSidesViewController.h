//
//  PLSelectSidesViewController.h
//  Plate
//
//  Created by emileleon on 12/1/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLOrderSummaryViewController.h"
#import "PLBaseOrderViewController.h"

@interface PLSelectSidesViewController : PLBaseOrderViewController

//- (IBAction)viewOrderSummary:(id)sender;
@property (nonatomic, strong) PLOrderSummaryViewController *orderSummaryController;
@end
