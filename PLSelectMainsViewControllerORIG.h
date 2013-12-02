//
//  PLSelectMainsViewController.h
//  Plate
//
//  Created by emileleon on 11/30/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLSelectMainsViewControllerORIG : UIViewController  <UITableViewDelegate, UITableViewDataSource>

- (IBAction)displaySides:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableMains;
@end
