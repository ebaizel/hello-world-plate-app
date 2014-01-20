//
//  PLALaCarteSummaryViewController.h
//  Plate
//
//  Created by emileleon on 12/24/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLALaCarteSummaryViewController : UIViewController
- (IBAction)addToBasket:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mainsToBeAdded;
@property (weak, nonatomic) IBOutlet UILabel *sidesToBeAdded;

@end
