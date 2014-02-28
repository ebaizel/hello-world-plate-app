//
//  PLSelectSidesViewController.m
//  Plate
//
//  Created by emileleon on 12/1/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectSidesViewController.h"
#import "PLOrderSummaryViewController.h"
#import "PLPlateStore.h"
#import "PLMenuItemTableViewCell.h"
#import "PLBasketStore.h"
#import "PLMenuItem.h"
#import "PLPlate.h"
#import "Colours.h"

@interface PLSelectSidesViewController ()

@end

@implementation PLSelectSidesViewController

@synthesize orderSummaryController;

#pragma mark - Table view data source

- (void)fetchSides
{

    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    __weak PLSelectSidesViewController *weakSelf = self;
    
    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
    [[PLPlateStore sharedStore] getPlateMenu:[plate plateSize] plateType:[plate plateTypeSize] forBlock:^(PLMenu *menuResult, NSError *err) {
        
        [[weakSelf navigationItem] setTitleView:currentTitleView];
        
        if (!err) {
            sides = [menuResult sides];
            [[weakSelf tableSides] reloadData];
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sides count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PLMenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLMenuItemTableViewCell"];
    if (cell == nil) {
        cell = [[PLMenuItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PLMenuItemTableViewCell"];
    }
    
    [cell setupDelegate:self parentTable:tableView];
    PLMenuItem *item = [sides objectAtIndex:[indexPath row]];
    
    cell.itemNameLabel.text = [item name];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%d",[[PLBasketStore sharedStore] quantityOfSideInPlateBuilder: item]];
    cell.itemId = [item plateId];
    cell.textLabel.textColor = [UIColor moneyGreenColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[PLBasketStore sharedStore] addPlateSide:[sides objectAtIndex:[indexPath row]]];
    [tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sides";
    self.orderSummaryController = [[PLOrderSummaryViewController alloc]init];
    
    UINib *nib = [UINib nibWithNibName:@"PLMenuItemTableViewCell" bundle:nil];
    [[self tableSides] registerNib:nib forCellReuseIdentifier:@"PLMenuItemTableViewCell"];
    
    [self fetchSides];
    
    int numSides = 0;
    NSString *slug = [[[[PLBasketStore sharedStore] plateBuilder] plateTypeSize] typeSlug];
    if ([slug isEqualToString:OneMainTwoSides]) {
        numSides = 2;
    } else if ([slug isEqualToString:FourSides]) {
        numSides = 4;
    }
    self.labelSelectSides.text = [NSString stringWithFormat:@"Select %d sides", numSides];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.title = @"Sides";
//    self.orderSummaryController = [[PLOrderSummaryViewController alloc]init];
//
//    UINib *nib = [UINib nibWithNibName:@"PLMenuItemTableViewCell" bundle:nil];
//    [[self tableSides] registerNib:nib forCellReuseIdentifier:@"PLMenuItemTableViewCell"];
//    
//    [self fetchSides];
//
//    int numSides = 0;
//    if ([[[PLBasketStore sharedStore] plateBuilder] type] == OneMain) {
//        numSides = 2;
//    } else if ([[[PLBasketStore sharedStore] plateBuilder] type] == FourSides) {
//        numSides = 4;
//    }
//    self.labelSelectSides.text = [NSString stringWithFormat:@"Select %d sides", numSides];
//}

-(int)addItemWithCell:(PLMenuItemTableViewCell *)cell
{
    PLMenuItem *item = [self getItemFromCell:cell];
    
    [[PLBasketStore sharedStore] addPlateSide:item];
    [cell.parentTableView reloadData];
    [self setStatusButton];
    return [[PLBasketStore sharedStore] quantityOfSideInPlateBuilder:item];
}

-(int)removeItemWithCell:(PLMenuItemTableViewCell *)cell
{
    PLMenuItem *item = [self getItemFromCell:cell];
    
    [[PLBasketStore sharedStore] removePlateSide:item];
    [cell.parentTableView reloadData];
    [self setStatusButton];    
    return [[PLBasketStore sharedStore] quantityOfSideInPlateBuilder:item];
}

- (PLMenuItem *)getItemFromCell:(PLMenuItemTableViewCell *)cell
{
    PLMenuItem *item = nil;
    for (PLMenuItem *side in sides) {
        if ([cell.itemId isEqualToString:[side plateId]]) {
            item = side;
            break;
        }
    }
    return item;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)displayItemDetail:(PLMenuItemTableViewCell *)cell
{
    PLMenuItem *item = [self getItemFromCell:cell];
    PLItemDetailController *plidc = [[PLItemDetailController alloc]initWithMenuItem:item];
    [plidc setDelegate:self];
    [self presentViewController:plidc animated:YES completion:nil];
}

- (void)dismissItemDetailView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super displayBasketInNavBar];
    [self setStatusButton];
}

- (void)setStatusButton
{
    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
    int numSidesNeeded = 0;
    NSString *slug = [[[[PLBasketStore sharedStore] plateBuilder] plateTypeSize] typeSlug];
    if ([slug isEqualToString:OneMainTwoSides]) {
        numSidesNeeded = 2;
    } else if ([slug isEqualToString:FourSides]) {
        numSidesNeeded = 4;
    }

    UIBarButtonItem *statusButton = [[self toolbarItems] objectAtIndex:0];
    int numSidesAdded = [[plate sides] count];
    
    NSString *status = [NSString stringWithFormat:@"%d of %d", numSidesAdded, numSidesNeeded];
    [statusButton setTitle:status];
}

- (IBAction)actionContinue:(id)sender {

    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
    int numSidesNeeded = 0;

    NSString *slug = [[[[PLBasketStore sharedStore] plateBuilder] plateTypeSize] typeSlug];
    if ([slug isEqualToString:OneMainTwoSides]) {
        numSidesNeeded = 2;
    } else if ([slug isEqualToString:FourSides]) {
        numSidesNeeded = 4;
    }

    int numSidesAdded = [[plate sides] count];
    
    if  (numSidesNeeded != numSidesAdded) {
        NSString *msg = [NSString stringWithFormat:@"Select %d sides", numSidesNeeded];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                        message:@"Please select additional sides"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    } else {
        [[self navigationController] pushViewController:[self orderSummaryController] animated:YES];
    }
}
@end
