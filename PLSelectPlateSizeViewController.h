//
//  PLPlateCreate10Controller.h
//  Plate
//
//  Created by emileleon on 11/27/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLSelectPlateSizeViewController;
@class PLSelectMainsViewController;

@interface PLSelectPlateSizeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *plateTypeTable;
@property (weak, nonatomic) IBOutlet UITableView *plateSizeTable;
@property (strong, nonatomic) IBOutlet PLSelectMainsViewController *mainsViewController;
- (IBAction)displayMains:(id)sender;

@end