//
//  PLHomeViewController.m
//  Plate
//
//  Created by emileleon on 11/26/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLStartOrderViewController.h"
#import "PLSelectPlateSizeViewController.h"
#import "PLALaCarteViewController.h"
#import "PLAddOnViewController.h"
#import "PLBasketStore.h"
#import "PLBasketViewController.h"
#import "Colours.h"

@interface PLStartOrderViewController ()

@end

@implementation PLStartOrderViewController


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self orderTypeTableView]) {
 
        if ([indexPath row] == 0) {
            [[self navigationController] pushViewController:[self selectSizeController] animated:YES];
        } else if ([indexPath row] == 1) {
            [[self navigationController] pushViewController:[self alaCarteViewController] animated:YES];
        } else if ([indexPath row] == 2) {
            [[self navigationController] pushViewController:[self addOnViewController] animated:YES];
        }
    } else if (tableView == [self basketSummaryTable]) {
        if ([[PLBasketStore sharedStore] quantityOfAllItemsInBasket] >0) {
            [self viewBasket];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == [self orderTypeTableView]) {
        return [startingOptions count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    
    //    cell.layer.borderWidth = 1.0f;
    //    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    //    cell.layer.masksToBounds = YES;
    //    cell.layer.cornerRadius = 12.0f;
    //    cell.layer.backgroundColor = [[UIColor grayColor] CGColor];

    if (tableView == [self orderTypeTableView]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor moneyGreenColor];
        [[cell textLabel] setText:[startingOptions objectAtIndex:[indexPath row]]];
    } else {

        //        UIFont *basketFont = [ UIFont fontWithName: @"Arial" size: 12.0 ];
        //        cell.textLabel.font = basketFont;

        int quantity = [[PLBasketStore sharedStore] quantityOfAllItemsInBasket];

        if  (quantity > 0) {
            cell.textLabel.textColor = [UIColor moneyGreenColor];
            NSString *basketText = [NSString stringWithFormat:@"%d items in basket", quantity];
            cell.textLabel.text = basketText;
            
            cell.detailTextLabel.textColor = [UIColor moneyGreenColor];

            NSString *displayCost = [NSString localizedStringWithFormat:@"%.2F", [[PLBasketStore sharedStore] totalCostOfItemsInBasket]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Total Cost: $%@", displayCost];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        } else {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.text = @"Basket is currently empty";
            cell.detailTextLabel.text = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    return cell;

}

#pragma INIT METHODS

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

- (void)reloadTableViewData
{
    [[self orderTypeTableView] reloadData];
    [[self basketSummaryTable] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!startingOptions) {
        startingOptions = [[NSArray alloc]initWithObjects:@"Create a Plate", @"A la carte", @"Add ons", nil];
    }

    [self setTitle:@"PLATE"];

    PLSelectPlateSizeViewController *plpsvc = [[PLSelectPlateSizeViewController alloc]init];
    plpsvc.hidesBottomBarWhenPushed = YES;
    [self setSelectSizeController:plpsvc];
    
    PLALaCarteViewController *plalacartevc = [[PLALaCarteViewController alloc]init];
    plalacartevc.hidesBottomBarWhenPushed = YES;
    [self setAlaCarteViewController:plalacartevc];
    
    PLAddOnViewController *plaovc = [[PLAddOnViewController alloc]init];
    plaovc.hidesBottomBarWhenPushed = YES;
    [self setAddOnViewController:plaovc];

}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewBasket {
    // Display contents of basket
    PLBasketViewController *bvc = [[PLBasketViewController alloc] init];
    bvc.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:bvc animated:YES];
}
@end
