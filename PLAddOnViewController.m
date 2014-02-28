//
//  PLAddOnViewController.m
//  Plate
//
//  Created by emileleon on 1/16/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLAddOnViewController.h"
#import "PLBasketStore.h"
#import "PLAddOnItem.h"
#import "PLMenuItemTableViewCell.h"
#import "PLALaCarteSummaryViewController.h"
#import "PLAddOnSummaryViewController.h"
#import "Colours.h"
#import "PLPlateStore.h"
#import "PLMenu.h"
#import "PLItemDetailController.h"

@interface PLAddOnViewController ()

@end

@implementation PLAddOnViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PLMenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLMenuItemTableViewCell"];
    if (cell == nil) {
        cell = [[PLMenuItemTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLMenuItemTableViewCell"];
    }

    [cell setupDelegate:self parentTable:(UITableView *)tableView];
    
    PLAddOnItem *item = nil;
    item = [[self addOns] objectAtIndex:[indexPath row]];

    cell.itemNameLabel.text = [item name];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%d",[[PLBasketStore sharedStore] quantityOfItemInAddOnBuilder: item]];  // get value from basket builder
    cell.itemId = [item plateId];
    
    return cell;
    
}

- (void)displayItemDetail:(PLMenuItemTableViewCell *)cell
{
    PLAddOnItem *item = [self getItemFromCell:cell];
    PLItemDetailController *plidc = [[PLItemDetailController alloc]initWithMenuItem:item];
    [plidc setDelegate:self];
    [self presentViewController:plidc animated:YES completion:nil];
}

- (void)dismissItemDetailView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PLAddOnItem *)getItemFromCell:(PLMenuItemTableViewCell *)cell
{
    PLAddOnItem *item = nil;
    
    for (PLAddOnItem *addOnItem in self.addOns) {
        if ([cell.itemId isEqualToString:[addOnItem plateId]]) {
            item = addOnItem;
            break;
        }
    }
    return item;
}

// Action for + button; adds the item to the builder
-(int)addItemWithCell:(PLMenuItemTableViewCell *)cell
{
    PLAddOnItem *item = [self getItemFromCell:cell];
    
    int numItems = [[PLBasketStore sharedStore] addAddOnItem:item];
    [self setStatusButton];
    return numItems;
}

// Action for - button; removes the item from the builder
-(int)removeItemWithCell:(PLMenuItemTableViewCell *)cell
{
    PLAddOnItem *item = [self getItemFromCell:cell];

    int numItems = [[PLBasketStore sharedStore] removeAddOnItem:item];
    [self setStatusButton];
    return numItems;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadTableViewData)
                                                     name:@"AddOnBuilderEmptied" object:nil];
    }
    return self;
}

- (void)reloadTableViewData
{
    [self.addOnsTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self addOns] count];
}

- (void)setStatusButton
{
    UIBarButtonItem *statusButton = [[self toolbarItems] objectAtIndex:0];
    int numAddOnsAdded = [[PLBasketStore sharedStore] quantityOfItemsInAddOnBuilder];
    NSString *status = [NSString stringWithFormat:@"%d items selected", numAddOnsAdded];
    [statusButton setTitle:status];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Display the Continue button
    self.navigationController.toolbarHidden = NO;
    
    // We don't want extra space above tables for scrolling
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.addOnsTable.backgroundColor = [UIColor clearColor];
    [self.addOnsTable reloadData];
    
    [super displayBasketInNavBar];
    [self setStatusButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"PLMenuItemTableViewCell" bundle:nil];
    [[self addOnsTable] registerNib:nib forCellReuseIdentifier:@"PLMenuItemTableViewCell"];
    [self fetchAddOnItems];
    [self setTitle:@"Add Ons"];

    // Setup the navigation bar
    [[self navigationItem] setTitle:@"Add Ons"];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica" size:24], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

- (void)fetchAddOnItems
{
    
    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    __weak PLAddOnViewController *weakSelf = self;
    
    [[PLPlateStore sharedStore]getAddOnMenu:^(PLMenu *menuResult, NSError *err) {
        
        [[weakSelf navigationItem] setTitleView:currentTitleView];
        
        if (!err) {
            _addOns = [menuResult addons];
            [[weakSelf addOnsTable] reloadData];
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

//-(void)fetchAddOnItems
//{
//    NSMutableArray *addOnItems = [[NSMutableArray alloc]init];
//    
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Coca Cola" itemType:MenuItemAddOn itemId:@"1"]];
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Cheez Whiz" itemType:MenuItemAddOn itemId:@"2"]];
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Faygo" itemType:MenuItemAddOn itemId:@"3"]];
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Frito Lays" itemType:MenuItemAddOn itemId:@"4"]];
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Chips Ahoy" itemType:MenuItemAddOn itemId:@"5"]];
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Saltines" itemType:MenuItemAddOn itemId:@"6"]];
//    [addOnItems addObject:[[PLAddOnItem alloc]initWithName:@"Vanilla Wafers" itemType:MenuItemAddOn itemId:@"7"]];
//    
//    for (PLAddOnItem *item in addOnItems) {
//        item.price = 2.0;
//    }
//    
//    [self setAddOns:addOnItems];
//}

- (IBAction)actionContinue:(id)sender {
    [[self navigationController] pushViewController:[[PLAddOnSummaryViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
