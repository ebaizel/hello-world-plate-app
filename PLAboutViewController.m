//
//  PLAboutViewController.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLAboutViewController.h"

@interface PLAboutViewController ()

@end

@implementation PLAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Does this display?"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"About Plate";    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
