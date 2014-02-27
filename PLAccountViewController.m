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

@interface PLAccountViewController ()

@end

@implementation PLAccountViewController


- (void)setUsername
{
    PLAccount *user = [[PLAccountStore sharedStore] getAccount];
    if (user) {
        self.labelUsername.text = user.login;
    } else {
        self.labelUsername.text = @"not logged in";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSLog(@"Logging in.  Display modal window");
    _pllsvc = [[PLLoginSignUpViewController alloc]init];
    [[self pllsvc] setDelegate:self];
    [self presentViewController:_pllsvc animated:YES completion:nil];
}

- (IBAction)logout:(id)sender {
    [[PLAccountStore sharedStore] logout];
}

- (void)dismissModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userLoggedIn
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
                                                 selector:@selector(setUsername)
                                                     name:@"UserLoggedIn" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setUsername)
                                                     name:@"UserLoggedOut" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Settings";
    [self setUsername];
}
@end
