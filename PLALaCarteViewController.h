//
//  PLALaCarteViewController.h
//  Plate
//
//  Created by emileleon on 12/23/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLMenuItemTableViewCell.h"
#import "PLBaseOrderViewController.h"
#import "PLItemDetailController.h"

@interface PLALaCarteViewController : PLBaseOrderViewController <MenuItemTableViewCellDelegate, ItemDetailDelegate>

@property (weak, nonatomic) IBOutlet UITableView *alaCarteMains;
@property (weak, nonatomic) IBOutlet UITableView *alaCarteSides;

@property (nonatomic, strong) NSMutableArray *mains;
@property (nonatomic, strong) NSMutableArray *sides;

@end
