//
//  PLAddOnSummaryViewController.h
//  Plate
//
//  Created by emileleon on 1/16/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLAddOnSummaryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *summary;
- (IBAction)addToBasket:(id)sender;
@end
