//
//  PLAddOnViewController.h
//  Plate
//
//  Created by emileleon on 1/16/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLMenuItemTableViewCell.h"

@interface PLAddOnViewController : UIViewController <ALaCarteCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *addOnsTable;
@property (nonatomic, strong) NSMutableArray *addOns;

@end
