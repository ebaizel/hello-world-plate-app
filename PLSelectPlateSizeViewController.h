//
//  PLPlateCreate10Controller.h
//  Plate
//
//  Created by emileleon on 11/27/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseOrderViewController.h"
@class PLSelectPlateSizeViewController;
@class PLSelectMainsViewController;
@class PLSelectSidesViewController;

@interface PLSelectPlateSizeViewController : PLBaseOrderViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *plateTypes; // main with two sides, or 4 sides
    NSArray *plateSizes; // ultra, fit, kids
}
@property (weak, nonatomic) IBOutlet UITableView *plateTypeTable;
@property (weak, nonatomic) IBOutlet UITableView *plateSizeTable;
@property (strong, nonatomic) PLSelectMainsViewController *mainsViewController;
@property (strong, nonatomic) PLSelectSidesViewController *sidesViewController;

@end