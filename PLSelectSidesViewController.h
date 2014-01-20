//
//  PLSelectSidesViewController.h
//  Plate
//
//  Created by emileleon on 12/1/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseOrderViewController.h"
#import "PLMenuItemTableViewCell.h"
@class PLOrderSummaryViewController;

@interface PLSelectSidesViewController : PLBaseOrderViewController <ALaCarteCellDelegate>
{
    NSArray *sides;
}
@property (weak, nonatomic) IBOutlet UILabel *labelSelectSides;
@property (weak, nonatomic) IBOutlet UITableView *tableSides;
@property (nonatomic, strong) PLOrderSummaryViewController *orderSummaryController;
@end
