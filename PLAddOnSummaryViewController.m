//
//  PLAddOnSummaryViewController.m
//  Plate
//
//  Created by emileleon on 1/16/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLAddOnSummaryViewController.h"
#import "PLAddOnItem.h"
#import "PLBasketStore.h"

@interface PLAddOnSummaryViewController ()

@end

@implementation PLAddOnSummaryViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *addOnSummary = [NSString stringWithFormat:@""];
    for (PLAddOnItem *basketItem in [[PLBasketStore sharedStore] addOnBuilder]) {
        NSString *addOnText = [NSString stringWithFormat:@"%@: Qty %d\n", [basketItem name], [basketItem quantity]];
        addOnSummary = [addOnSummary stringByAppendingString:addOnText];
    }
    
    if ([addOnSummary length] == 0) {
        addOnSummary = @"No Add Ons selected";
    }
    
    [[self summary] setText:addOnSummary];
    [super displayBasketInNavBar];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToBasket:(id)sender {
    [[PLBasketStore sharedStore] addAddOnItemsToBasket];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
