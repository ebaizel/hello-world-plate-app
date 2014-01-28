//
//  PLBasketViewController.h
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBasketViewTableCell.h"

@interface PLBasketViewController : UIViewController <BasketViewTableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *basketTable;
@end
