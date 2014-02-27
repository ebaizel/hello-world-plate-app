//
//  PLSettingsViewController.h
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLLoginSignUpViewController.h"

@interface PLAccountViewController : UIViewController <LoginModalDelegate>

@property (strong, nonatomic) PLLoginSignUpViewController *pllsvc;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;

@end
