//
//  PLBasketViewController.h
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBasketViewTableCell.h"
#import "PLPaymentViewController.h"

@interface PLBasketViewController : UIViewController <BasketViewTableCellDelegate, AddPaymentModalDelegate>

@property (weak, nonatomic) IBOutlet UITableView *basketTable;
@property (strong, nonatomic) PLPaymentViewController *plpvc;
@end
