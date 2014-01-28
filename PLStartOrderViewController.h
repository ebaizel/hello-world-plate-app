//
//  PLHomeViewController.h
//  Plate
//
//  Created by emileleon on 11/26/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseOrderViewController.h"
#import "PLALaCarteViewController.h"
#import "PLAddOnViewController.h"

@class PLSelectPlateSizeViewController;

@interface PLStartOrderViewController : PLBaseOrderViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *startingOptions;
}

@property (weak, nonatomic) IBOutlet UITableView *orderTypeTableView;
@property (weak, nonatomic) IBOutlet UITableView *basketSummaryTable;

@property (nonatomic, strong) PLSelectPlateSizeViewController *selectSizeController;
@property (nonatomic, strong) PLALaCarteViewController *alaCarteViewController;
@property (nonatomic, strong) PLAddOnViewController *addOnViewController;

@end
