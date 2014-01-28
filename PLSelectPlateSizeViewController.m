//
//  PLPlateCreate10Controller.m
//  Plate
//
//  Created by emileleon on 11/27/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectPlateSizeViewController.h"
#import "PLSelectMainsViewController.h"
#import "PLSelectSidesViewController.h"
#import "PLBasketStore.h"
#import "PLPlate.h"
#import "Colours.h"

@interface PLSelectPlateSizeViewController ()

@end

@implementation PLSelectPlateSizeViewController

@synthesize mainsViewController;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self plateTypeTable]) {  // Plate Type
        if ([indexPath row] == 0) {
            [[[PLBasketStore sharedStore] plateBuilder] setType:OneMain];
        } else {
            [[[PLBasketStore sharedStore] plateBuilder] setType:FourSides];
        }
    } else {  // Plate Size
        if ([indexPath row] == 0) {
            [[[PLBasketStore sharedStore] plateBuilder] setSize:Fit];
        } else if ([indexPath row] == 1) {
            [[[PLBasketStore sharedStore] plateBuilder] setSize:Ultra];
        } else if ([indexPath row] == 2) {
            [[[PLBasketStore sharedStore] plateBuilder] setSize:Kids];
        }
    }
    
    [self reloadTableViewData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self plateSizeTable] == tableView) {
        return [plateSize count];
    } else {
        return [plateType count];
    }
}

- (void)reloadTableViewData
{
    [self.plateTypeTable reloadData];
    [self.plateSizeTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 12.0f;
    cell.layer.backgroundColor = [[UIColor grayColor] CGColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor moneyGreenColor];
    
    if (tableView == [self plateTypeTable]) {  // Plate Type

        [[cell textLabel] setText:[plateType objectAtIndex:[indexPath row]]];

        // Add the checkmark if a type has been set
        PlateType currentType = [[[PLBasketStore sharedStore] plateBuilder] type];
        if (([indexPath row] == 0) && (currentType == OneMain)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else if (([indexPath row] == 1) && (currentType == FourSides)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }

    } else {  // Plate Size

        [[cell textLabel] setText:[plateSize objectAtIndex:[indexPath row]]];
        
        // Add the checkmark if a size has been set
        PlateSize currentSize = [[[PLBasketStore sharedStore] plateBuilder] size];
        if (([indexPath row] == 0) && (currentSize == Fit)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else if (([indexPath row] == 1) && (currentSize == Ultra)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else if (([indexPath row] == 2) && (currentSize == Kids)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }

    }
    
    return cell;
    
}

#pragma INITIALIZERS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mainsViewController = [[PLSelectMainsViewController alloc] init];
        self.sidesViewController = [[PLSelectSidesViewController alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadTableViewData)
                                                     name:@"PlateBuilderEmptied" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!plateType) {
        plateType = [[NSArray alloc]initWithObjects:@"1 Main with 2 Sides", @"4 Sides", nil];
    }
    
    if (!plateSize) {
        plateSize = [[NSArray alloc]initWithObjects:@"Fit", @"Ultra", @"Kids", nil];
    }
    
    [self setTitle:@"Sizes"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContinue:(id)sender {

    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
    if  (([plate size] == UndefinedSize) || ([plate type] == UndefinedType)) {
        NSString *msg = [NSString stringWithFormat:@"Select a type and size"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                        message:@"Please select your Plate's size and type"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];

        [alert show];
    } else {
        
        // Empty out the plate builder before continuing
        [plate setMain:nil];
        [plate setSides:[[NSMutableArray alloc]init]];
        
        if ([plate type] == OneMain) {
            [[self navigationController] pushViewController:[self mainsViewController] animated:YES];
        } else if ([plate type] == FourSides) {
            [[self navigationController] pushViewController:[self sidesViewController] animated:YES];
        }
    }
}
@end







