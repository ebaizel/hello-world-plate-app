//
//  PLSelectMainsViewController.h
//  Plate
//
//  Created by emileleon on 11/30/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseOrderViewController.h"
@class PLSelectSidesViewController;

@interface PLSelectMainsViewController : PLBaseOrderViewController  <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *mains;
}
@property (nonatomic, weak) IBOutlet UITableView *tableMains;
@property (nonatomic, strong) PLSelectSidesViewController *sidesController;
@end
