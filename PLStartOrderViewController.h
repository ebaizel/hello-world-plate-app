//
//  PLHomeViewController.h
//  Plate
//
//  Created by emileleon on 11/26/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseOrderViewController.h"

@class PLSelectPlateSizeViewController;

@interface PLStartOrderViewController : PLBaseOrderViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *startingOptions;
}
@property (nonatomic, strong) PLSelectPlateSizeViewController *selectSizeController;

@end
