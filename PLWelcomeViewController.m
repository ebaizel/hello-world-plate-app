//
//  PLWelcomeViewController.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLWelcomeViewController.h"
#import "PLLoginSignUpViewController.h"

@interface PLWelcomeViewController ()

@end

@implementation PLWelcomeViewController

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
    self.navigationItem.title = @"Plate";
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    _pllsvc = [[PLLoginSignUpViewController alloc]init];
    [[self pllsvc] setDelegate:self];
    [self presentViewController:_pllsvc animated:YES completion:nil];
}

- (IBAction)skipWelcome:(id)sender {
    [[self delegate] skipWelcomeScreen];
}

#pragma Login Delegate methods

- (void)dismissModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userLoggedIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //User successfully logged in; let's pop ourselves
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
