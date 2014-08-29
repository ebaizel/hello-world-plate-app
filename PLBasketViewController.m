//
//  PLBasketViewController.m
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLBasketViewController.h"
#import "PLBasketStore.h"
#import "PLAddOnItem.h"
#import "PLALaCarteItem.h"
#import "PLPlate.h"
#import "Colours.h"


@interface PLBasketViewController ()

@end

@implementation PLBasketViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *theCell;
    switch ([indexPath section]) {
        case 0: {     // Plates section
            PLBasketViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLBasketViewTableCellPlate"];
            if (cell == nil) {
                cell = [[PLBasketViewTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLBasketViewTableCellPlate"];
            }

            cell.itemType = Plate;
            cell.itemIndex = [indexPath row];
            cell.delegate = self;
            
            PLPlate *plate = (PLPlate *)[[[PLBasketStore sharedStore] plates] objectAtIndex:[indexPath row]];
            if ([plate main]) {
                cell.itemNameLabel.text = [[plate main] name];
            } else {
                cell.itemNameLabel.text = @"No main";
            }

            if ([plate sides]) {
                PLMenuItem *side = [[plate sides] objectAtIndex:0];
                if (side) {
                    cell.side1Label.text = [side name];
                } else {
                    cell.side1Label.text = @"";
                }
                
                side = [[plate sides] objectAtIndex:1];
                if (side) {
                    cell.side2Label.text = [side name];
                } else {
                    cell.side2Label.text = @"";
                }
                
                NSString *slug = [[[[PLBasketStore sharedStore] plateBuilder] plateTypeSize] typeSlug];
                if ([slug isEqualToString:FourSides]) {
                    side = [[plate sides] objectAtIndex:2];
                    cell.side3Label.text = [side name];
                
                    side = [[plate sides] objectAtIndex:3];
                    cell.side4Label.text = [side name];

                } else {
                    cell.side3Label.text = @"";
                    cell.side4Label.text = @"";
                }
            }
            
            if ([plate size] == Ultra) {
                cell.plateSizeLabel.text = @"Ultra";
                cell.priceLabel.text = @"$15";
            } else if ([plate size] == Fit) {
                cell.plateSizeLabel.text = @"Fit";
                cell.priceLabel.text = @"$12";
            } else if ([plate size] == Kids) {
                cell.plateSizeLabel.text = @"Kids";
                cell.priceLabel.text = @"$8";
            }

            theCell = cell;
            break;
        }
        case 1: {    // A La Carte section
            PLBasketViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLBasketViewTableCellAddOn"];
            if (cell == nil) {
                cell = [[PLBasketViewTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLBasketViewTableCellAddOn"];
            }
            cell.itemType = ALaCarte;
            cell.delegate = self;
            cell.itemIndex = [indexPath row];

            PLALaCarteItem *item = nil;
            item = (PLALaCarteItem *)[[[PLBasketStore sharedStore] alaCarteItems] objectAtIndex:[indexPath row]];
            cell.itemId = item.plateId;
            cell.itemNameLabel.text = item.name;
            cell.quantityLabel.text = [NSString stringWithFormat:@"%d",[item quantity]];
            cell.priceLabel.text = [NSString stringWithFormat:@"$%.2f", item.price * [item quantity]];
            
            theCell = cell;
            break;
        }
        case 2: {    // Add On Section
            PLBasketViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLBasketViewTableCellAddOn"];
            if (cell == nil) {
                cell = [[PLBasketViewTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLBasketViewTableCellAddOn"];
            }
            cell.itemType = AddOn;
            cell.delegate = self;
            cell.itemIndex = [indexPath row];
            
            PLAddOnItem *item = nil;
            item = (PLAddOnItem *)[[[PLBasketStore sharedStore] addOns] objectAtIndex:[indexPath row]];
            cell.itemId = item.plateId;
            cell.itemNameLabel.text = item.name;
            cell.quantityLabel.text = [NSString stringWithFormat:@"%d",[item quantity]];
            float price = item.price * [item quantity];
            cell.priceLabel.text = [NSString stringWithFormat:@"$%.2f", price];
            
            theCell = cell;
            break;
        }
    }

    return theCell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    switch (section) {
        case 0: {
            if ([[[PLBasketStore sharedStore] plates] count] > 0) {
                return @"Plates";
            } else {
                return nil;
            }
        }
        case 1: {
            if ([[[PLBasketStore sharedStore] alaCarteItems] count] > 0) {
                return @"A La Carte";
            } else {
                return nil;
            }
        }
        case 2: {
            if ([[[PLBasketStore sharedStore] addOns] count] > 0) {
                return @"Add Ons";
            } else {
                return nil;
            }
        }
    }

    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: {
            return [[[PLBasketStore sharedStore] plates] count];
        }
        case 1: {
            return [[[PLBasketStore sharedStore] alaCarteItems] count];
        }
        case 2: {
            return [[[PLBasketStore sharedStore] addOns] count];
        }
    }
    return 0;
}

-(void)reloadTableViewData
{
    [[self basketTable] reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadTableViewData)
                                                     name:@"BasketUpdated" object:nil];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return 123.0f;
    } else {
        return 82.0f;
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nibAddOn = [UINib nibWithNibName:@"PLBasketViewTableCellAddOn" bundle:nil];
    [[self basketTable] registerNib:nibAddOn forCellReuseIdentifier:@"PLBasketViewTableCellAddOn"];
    
    UINib *nibPlate = [UINib nibWithNibName:@"PLBasketViewTableCellPlate" bundle:nil];
    [[self basketTable] registerNib:nibPlate forCellReuseIdentifier:@"PLBasketViewTableCellPlate"];
    
    // Setup the navigation bar
    [[self navigationItem] setTitle:@"My Basket"];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica" size:24], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    // Setup the bottom toolbar
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Continue to Payment" style:UIBarButtonItemStylePlain target:self action:@selector(actionContinue:)];
    [barButton setTitleTextAttributes:@{
                                        NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:18.0],
                                        NSForegroundColorAttributeName: [UIColor moneyGreenColor]
                                        } forState:UIControlStateNormal];
    
    self.toolbarItems = [NSArray arrayWithObjects: flexibleSpaceLeft, barButton, nil];
    
    // We don't want extra space above tables for scrolling
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
}


- (IBAction)actionContinue:(id)sender {
    
//    if ([[PLBasketStore sharedStore] quantityOfAllItemsInBasket] > 0) {
        // GO TO THE PAYMENT PAGE

        NSLog(@"Displaying payment modal from BasketView");
        _plpvc = [[PLPaymentViewController alloc]init];
        _plpvc.displaySaveToAccount = true;
        [[self plpvc] setDelegate:self];
        //[self presentViewController:_plpvc animated:YES completion:nil];

        [[self navigationController] pushViewController:_plpvc animated:YES];
//    }
}


- (void)dismissModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentAdded
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)removeItemWithCell:(PLBasketViewTableCell *)cell
{
    if (cell.itemType == Plate) {
        [[[PLBasketStore sharedStore] plates] removeObjectAtIndex:[cell itemIndex]];
    } else if (cell.itemType == ALaCarte) {
        [[[PLBasketStore sharedStore] alaCarteItems] removeObjectAtIndex:[cell itemIndex]];
    } else if (cell.itemType == AddOn) {
        [[[PLBasketStore sharedStore] addOns] removeObjectAtIndex:[cell itemIndex]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BasketUpdated" object:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
