//
//  PLALaCarteSummaryViewController.m
//  Plate
//
//  Created by emileleon on 12/24/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLALaCarteSummaryViewController.h"
#import "PLALaCarteItem.h"
#import "PLBasketStore.h"
#import "PLBasketViewController.h"

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
    
    NSString *mainsSummary = [NSString stringWithFormat:@""];
    NSString *sidesSummary = [NSString stringWithFormat:@""];
    for (PLALaCarteItem *item in [[PLBasketStore sharedStore] alaCarteBuilder]) {
        if ([item itemType] == MenuItemMain) {
            NSString *newMain = [NSString stringWithFormat:@"%@: Qty %d\n", [item name], [item quantity]];
            mainsSummary = [mainsSummary stringByAppendingString:newMain];
        } else if ([item itemType] == MenuItemSide) {
            NSString *newSide = [NSString stringWithFormat:@"%@: Qty %d\n", [item name], [item quantity]];
            sidesSummary = [sidesSummary stringByAppendingString:newSide];
        }
    }
    
    if ([mainsSummary length] == 0) {
        mainsSummary = @"no mains";
    }
    
    if ([sidesSummary length] == 0) {
        sidesSummary = @"no sides";
    }
    
    self.textMainsSummary.text = mainsSummary;
    self.textSidesSummary.text = sidesSummary;
    
//    self.mainsToBeAdded.text = mainsSummary;
//    self.sidesToBeAdded.text = sidesSummary;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super displayBasketInNavBar];
}

- (IBAction)addToBasket:(id)sender {
    
    [[PLBasketStore sharedStore] addALaCarteItemsToBasket];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
