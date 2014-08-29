//
//  PLSettingsViewController.h
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLLoginSignUpViewController.h"
#import "PLPaymentViewController.h"

@interface PLAccountViewController : UIViewController <LoginModalDelegate, AddPaymentModalDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelWelcome;
@property (strong, nonatomic) PLLoginSignUpViewController *pllsvc;
@property (strong, nonatomic) PLPaymentViewController *plpvc;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogout;

@property (weak, nonatomic) IBOutlet UILabel *labelRecentOrders;
@property (weak, nonatomic) IBOutlet UITextView *textRecentOrders;

@property (weak, nonatomic) IBOutlet UILabel *labelSavedPayments;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddNewPayment;
@property (weak, nonatomic) IBOutlet UITextView *textPayments;

- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)addPayment:(id)sender;

@end
