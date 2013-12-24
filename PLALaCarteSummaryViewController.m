//
//  PLALaCarteSummaryViewController.m
//  Plate
//
//  Created by emileleon on 12/24/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLALaCarteSummaryViewController.h"

@interface PLALaCarteSummaryViewController ()

@end

@implementation PLALaCarteSummaryViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToBasket:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
