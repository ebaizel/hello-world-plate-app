//
//  PLOrderSummaryViewController.m
//  Plate
//
//  Created by emileleon on 12/2/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLOrderSummaryViewController.h"
#import "PLBasketStore.h"
#import "PLStartOrderViewController.h"

@interface PLOrderSummaryViewController ()

@end

@implementation PLOrderSummaryViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
}

- (void)actionContinue:(id)sender
{
    NSLog(@"continue clicked from summary");
}

- (IBAction)addToBasket:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
//    [[self navigationController] pushViewController:[[PLStartOrderViewController alloc] init] animated:YES];
}
@end
