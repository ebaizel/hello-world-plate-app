//
//  PLOrderNavigationController.m
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLOrderNavigationController.h"
#import "PLStartOrderViewController.h"
#import "PLWelcomeViewController.h"
#import "PLAccountStore.h"
#import "PLAccount.h"

@interface PLOrderNavigationController ()

@end

@implementation PLOrderNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self view] setBackgroundColor:[UIColor purpleColor]];

//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(popWelcomeScreen)
//                                                     name:@"UserLoggedIn" object:nil];

//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(pushWelcomeScreen)
//                                                     name:@"UserLoggedOut" object:nil];
    }
    return self;
}

-(void)skipWelcomeScreen
{
    skipWelcome = YES;
    [self popViewControllerAnimated:YES];
//    [self setHomeView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg-grey.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    plsovc = [[PLStartOrderViewController alloc]init];
    [self pushViewController:plsovc animated:YES];
    
    // Push the Welcome screen if not logged in
    PLAccount *account = [[PLAccountStore sharedStore] getAccount];
    
    if (!account && !account.login && !skipWelcome) {
        _plwvc = [[PLWelcomeViewController alloc] init];
        _plwvc.delegate = self;
        _plwvc.navigationItem.hidesBackButton = YES;
        [self pushViewController:_plwvc animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
