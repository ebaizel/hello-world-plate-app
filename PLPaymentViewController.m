//
//  PLPaymentViewController.m
//  Plate
//
//  Created by Emile Baizel on 8/28/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLPaymentViewController.h"

@interface PLPaymentViewController ()

@end

@implementation PLPaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (false == _displaySaveToAccount) {
        self.switchSaveToAccount.hidden = true;
        self.labelSaveToAccount.hidden = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)closeModal:(id)sender {
    [[self delegate] dismissModal];
}

- (IBAction)save:(id)sender {
    NSLog(@"Payment saved");
    [[self delegate] paymentAdded];
}
@end
