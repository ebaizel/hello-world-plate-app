//
//  PLOrderNavigationController.m
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLOrderNavigationController.h"
#import "PLStartOrderViewController.h"

@interface PLOrderNavigationController ()

@end

@implementation PLOrderNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self view] setBackgroundColor:[UIColor purpleColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg-grey.png"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg-grey.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    [self pushViewController:[[PLStartOrderViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
