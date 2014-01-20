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
#import "PLPlate.h"

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
    
    NSString *plateSummary = [NSString stringWithFormat:@""];
    plateSummary = [plateSummary stringByAppendingString:@"Main:\n"];
    PLMenuItem *main = [[[PLBasketStore sharedStore]plateBuilder] main];
    if (main != nil) {
        plateSummary = [plateSummary stringByAppendingString:[[[[PLBasketStore sharedStore]plateBuilder]main]name]];
    } else {
        plateSummary = [plateSummary stringByAppendingString:@"no mains"];
    }

    plateSummary = [plateSummary stringByAppendingString:@"\n"];
    plateSummary = [plateSummary stringByAppendingString:@"Sides:\n"];
    
    for (PLMenuItem *side in [[[PLBasketStore sharedStore] plateBuilder]sides]) {
        plateSummary = [plateSummary stringByAppendingString:[side name]];
        plateSummary = [plateSummary stringByAppendingString:@"\n"];
    }
    
    [[self textSummary] setText:plateSummary];
}

- (void)actionContinue:(id)sender
{
    NSLog(@"continue clicked from summary");
}

- (IBAction)addToBasket:(id)sender {
    [[PLBasketStore sharedStore] addPlateToBasket];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
