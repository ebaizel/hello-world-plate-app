//
//  PLSettingsViewController.m
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLAccountViewController.h"
#import "PLAccountStore.h"
#import "PLAccount.h"
#import "PLPlateStore.h"
#import "PLOrder.h"
#import "PLPlateStore.h"

@interface PLAccountViewController ()

@end

@implementation PLAccountViewController


- (void)loadOrderHistory
{
    [[PLPlateStore sharedStore] getOrderHistory:^(NSMutableArray *orders, NSError *err) {

        if (!err) {
            NSString *orderHistorySummary = [NSString stringWithFormat:@""];
            for (PLOrder *order in orders) {
                NSString *orderSummary = [NSString stringWithFormat:@"%@ - $%f\n%@\n\n", @"November 12, 2014", [order cost], [order pickupOption]];
                orderHistorySummary = [orderHistorySummary stringByAppendingString:orderSummary];
            }
            
            if ([orderHistorySummary length] == 0) {
                orderHistorySummary = @"No order history";
            }
            
            self.textRecentOrders.text = orderHistorySummary;
            
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];
}

- (void)loadPayment
{
    [[PLPlateStore sharedStore] getPayment:^(PLPayment *payment, NSError *err) {
        
        if (!err) {
            NSString *paymentSummary = [NSString stringWithFormat:@""];
            paymentSummary = [NSString stringWithFormat:@"%@ ****%@ %@/%@", [payment cardType], [payment lastFourDigits], [payment expiryMonth], [payment expiryYear]];
            
            if ([paymentSummary length] == 0) {
                paymentSummary = @"No payments";
            }
            
            self.textPayments.text = paymentSummary;
            
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];
    
}


- (void)setState
{
    PLAccount *user = [[PLPlateStore sharedStore] getAccount];

    if (user) {  // logged in
        self.labelWelcome.text = @"Hello ";
        self.labelUsername.text = user.login;
        self.buttonLogin.hidden = true;
        self.buttonLogout.hidden = false;
        
        // display payment info
        self.labelSavedPayments.hidden = false;
        self.textPayments.hidden = false;
        self.buttonAddNewPayment.hidden = false;
        [self loadPayment];
        
        // display order history
        self.labelRecentOrders.hidden = false;
        self.textRecentOrders.hidden = false;
        [self loadOrderHistory];
        
        
    } else {  // not logged in
        self.labelWelcome.text = @"";
        self.labelUsername.text = @"";
        self.buttonLogin.hidden = false;
        self.buttonLogout.hidden = true;
        // hide payment info
        self.labelSavedPayments.hidden = true;
        self.textPayments.hidden = true;
        self.buttonAddNewPayment.hidden = true;
        // hide order history
        self.labelRecentOrders.hidden = true;
        self.textRecentOrders.hidden = true;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    _pllsvc = [[PLLoginSignUpViewController alloc]init];
    [[self pllsvc] setDelegate:self];
    [self presentViewController:_pllsvc animated:YES completion:nil];
}

- (IBAction)addPayment:(id)sender {
    NSLog(@"Displaying payment modal from AcctVC");
    _plpvc = [[PLPaymentViewController alloc]init];
    _plpvc.displaySaveToAccount = false;
    [[self plpvc] setDelegate:self];
    [self presentViewController:_plpvc animated:YES completion:nil];
}

- (IBAction)logout:(id)sender {
    [[PLPlateStore sharedStore] logout:^(NSError *err) {
        
        if (!err) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedOut" object:self];
            [self setState];
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];
}

- (void)dismissModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userLoggedIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentAdded
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Settings"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setState)
                                                     name:@"UserLoggedIn" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setState)
                                                     name:@"UserLoggedOut" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Settings";
    [self setState];

}

@end
