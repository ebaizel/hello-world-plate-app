//
//  PLALaCarteViewController.m
//  Plate
//
//  Created by emileleon on 12/23/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLALaCarteViewController.h"
#import "PLALaCarteSummaryViewController.h"
#import "PLALaCarteItem.h"
#import "PLMenuItemTableViewCell.h"
#import "PLBasketStore.h"
#import "Colours.h"
#import "PLPlateStore.h"
#import "PLBasketViewController.h"
#import "PLItemDetailController.h"

@interface PLALaCarteViewController ()

@end

@implementation PLALaCarteViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PLMenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLMenuItemTableViewCell"];
    if (cell == nil) {
        cell = [[PLMenuItemTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLMenuItemTableViewCell"];
    }
    
    [cell setupDelegate:self parentTable:(UITableView *)tableView];
    
    PLALaCarteItem *item = nil;
    if (tableView == [self alaCarteMains]) {
        item = [[self mains] objectAtIndex:[indexPath row]];
    } else if (tableView == [self alaCarteSides]) {
        item = [[self sides] objectAtIndex:[indexPath row]];
    }

    cell.itemNameLabel.text = [item name];

    cell.quantityLabel.text = [NSString stringWithFormat:@"%d",[[PLBasketStore sharedStore] quantityOfItemInALaCarteBuilder: item]];  // get value from basket builder
    cell.itemId = [item plateId];
    
    return cell;
    
}

- (void)displayItemDetail:(PLMenuItemTableViewCell *)cell
{
    PLALaCarteItem *item = [self getItemFromCell:cell];
    PLItemDetailController *plidc = [[PLItemDetailController alloc]initWithMenuItem:item];
    [plidc setDelegate:self];
    [self presentViewController:plidc animated:YES completion:nil];
}

- (void)dismissItemDetailView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PLALaCarteItem *)getItemFromCell:(PLMenuItemTableViewCell *)cell
{
    PLALaCarteItem *item = nil;
    if ([cell parentTableView] == [self alaCarteMains]) {
        for (id mainItem in self.mains) {
            if ([cell.itemId isEqualToString:[(PLALaCarteItem *) mainItem plateId]]) {
                item = (PLALaCarteItem *) mainItem;
                break;
            }
        }
    } else if ([cell parentTableView] == [self alaCarteSides]) {
        for (id sideItem in self.sides) {
            if ([cell.itemId isEqualToString:[(PLALaCarteItem *) sideItem plateId]]) {
                item = (PLALaCarteItem *) sideItem;
                break;
            }
        }
    }
    return item;
}

// Action for + button; adds the item to the builder
-(int)addItemWithCell:(PLMenuItemTableViewCell *)cell
{
    PLALaCarteItem *item = [self getItemFromCell:cell];
//    [[self alaCarteMains] reloadData];

    int numItems = [[PLBasketStore sharedStore] addALaCarteItem:item];
    [self setStatusButton];
    return numItems;
}

// Action for - button; removes the item from the builder
-(int)removeItemWithCell:(PLMenuItemTableViewCell *)cell
{
    PLALaCarteItem *item = [self getItemFromCell:cell];
    int numItems = [[PLBasketStore sharedStore] removeALaCarteItem:item];
    [self setStatusButton];
    return numItems;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == [self alaCarteMains]) {
        return [[self mains] count];
    } else if (tableView == [self alaCarteSides]) {
        return [[self sides] count];
    } else {
        return 0;
    }
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
                                                     name:@"ALaCarteBuilderEmptied" object:nil];
    }
    return self;
}

- (void)reloadTableViewData
{
    [self.alaCarteMains reloadData];
    [self.alaCarteSides reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Display the Continue button
    self.navigationController.toolbarHidden = NO;
    
    // We don't want extra space above tables for scrolling
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.alaCarteSides.backgroundColor = [UIColor clearColor];
    self.alaCarteMains.backgroundColor = [UIColor clearColor];
    
    [self.alaCarteMains reloadData];
    [self.alaCarteSides reloadData];
    
    [self displayBasketInNavBar];
    [self setStatusButton];
}

- (void)setStatusButton
{
    UIBarButtonItem *statusButton = [[self toolbarItems] objectAtIndex:0];
    int numALaCarteAdded = [[PLBasketStore sharedStore] quantityOfItemsInALaCarteBuilder];
    
    NSString *status = [NSString stringWithFormat:@"%d items selected", numALaCarteAdded];
    [statusButton setTitle:status];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"PLMenuItemTableViewCell" bundle:nil];
    [[self alaCarteMains] registerNib:nib forCellReuseIdentifier:@"PLMenuItemTableViewCell"];
    [[self alaCarteSides] registerNib:nib forCellReuseIdentifier:@"PLMenuItemTableViewCell"];
    [self setTitle:@"A La Carte"];
    [self fetchALaCarteItems];
    
    // Setup the navigation bar
    [[self navigationItem] setTitle:@"A La Carte"];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica" size:24], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

- (void)fetchALaCarteItems
{
    
    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    __weak PLALaCarteViewController *weakSelf = self;
    
    [[PLPlateStore sharedStore]getALaCarteMenu:^(PLMenu *menuResult, NSError *err) {
        
        [[weakSelf navigationItem] setTitleView:currentTitleView];
        
        if (!err) {
            _mains = [menuResult mains];
            _sides = [menuResult sides];
            [weakSelf reloadTableViewData];
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

//- (void)fetchALaCarteItems
//{
//    // This will be a call out to server
//    
//    NSMutableArray *mainItems = [[NSMutableArray alloc] init];
//    NSMutableArray *sideItems = [[NSMutableArray alloc] init];
//    
//    [mainItems addObject:[[PLALaCarteItem alloc] initWithName:@"Beef Stroganoff" itemType:MenuItemMain itemId:@"1"]];
//    [mainItems addObject:[[PLALaCarteItem alloc] initWithName:@"Wild Salmon" itemType:MenuItemMain itemId:@"2"]];
//    [mainItems addObject:[[PLALaCarteItem alloc] initWithName:@"Moo Goo Gai Pan" itemType:MenuItemMain itemId:@"3"]];
//
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Eggplant" itemType:MenuItemSide itemId:@"4"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Zucchini" itemType:MenuItemSide itemId:@"5"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Broccoli" itemType:MenuItemSide itemId:@"6"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Animal Crackers" itemType:MenuItemSide itemId:@"7"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Fudge Ice Cream" itemType:MenuItemSide itemId:@"8"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Spinach" itemType:MenuItemSide itemId:@"9"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Artichokes" itemType:MenuItemSide itemId:@"10"]];
//    [sideItems addObject:[[PLALaCarteItem alloc] initWithName:@"Side of Sardines" itemType:MenuItemSide itemId:@"11"]];
//    
//    for (PLALaCarteItem *item in mainItems) {
//        item.price = 10.0;
//    }
//    
//    for (PLALaCarteItem *item in sideItems) {
//        item.price = 4.0;
//    }
//    
//    [self setMains:mainItems];
//    [self setSides:sideItems];
//    
//}

- (IBAction)actionContinue:(id)sender {
    [[self navigationController] pushViewController:[[PLALaCarteSummaryViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
