//
//  PLLoginSignUpViewController.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLLoginSignUpViewController.h"
#import "PLAccountStore.h"
#import "PLAccount.h"

@interface PLLoginSignUpViewController ()

@end

@implementation PLLoginSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PLAccount *account = [[PLAccountStore sharedStore] getAccount];
    if (account) {
        _textEmail.text = account.login;
        _textPassword.text = account.password;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    PLAccount *account = [[PLAccount alloc]init];
    account.login = _textEmail.text;
    account.password = _textPassword.text;
    [[PLAccountStore sharedStore] login:account];
    [[self delegate] userLoggedIn];
}

- (IBAction)closeModal:(id)sender {
    [[self delegate] dismissModal];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}
@end
