//
//  PLBaseSettingsViewController.m
//  Plate
//
//  Created by emileleon on 12/6/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLBaseAccountViewController.h"
#import "PLAccountViewController.h"

@interface PLBaseAccountViewController ()

@end

@implementation PLBaseAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Account"];
        [[self view] setBackgroundColor:[UIColor purpleColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self pushViewController:[[PLAccountViewController alloc] init] animated:YES];
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
