//
//  PLBaseAboutViewController.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLBaseAboutViewController.h"
#import "PLAboutViewController.h"

@interface PLBaseAboutViewController ()

@end

@implementation PLBaseAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"About"];
        [[self view] setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self pushViewController:[[PLAboutViewController alloc] init] animated:YES];
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
