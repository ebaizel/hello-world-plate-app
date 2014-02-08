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
#import "PLPlateStore.h"
#import "PLPlate.h"
#import "Colours.h"
#import "PLPlatesTypesAndSizes.h"

@interface PLSelectPlateSizeViewController ()

@end

@implementation PLSelectPlateSizeViewController

@synthesize mainsViewController;

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView == [self plateTypeTable]) {  // Plate Type
//        if ([indexPath row] == 0) {
//            [[[PLBasketStore sharedStore] plateBuilder] setType:OneMain];
//        } else {
//            [[[PLBasketStore sharedStore] plateBuilder] setType:FourSides];
//        }
//    } else {  // Plate Size
//        if ([indexPath row] == 0) {
//            [[[PLBasketStore sharedStore] plateBuilder] setSize:Fit];
//        } else if ([indexPath row] == 1) {
//            [[[PLBasketStore sharedStore] plateBuilder] setSize:Ultra];
//        } else if ([indexPath row] == 2) {
//            [[[PLBasketStore sharedStore] plateBuilder] setSize:Kids];
//        }
//    }
//    
//    [self reloadTableViewData];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self plateTypeTable]) {  // Plate Type
        PLPlateTypeSize *selectedPlateTypeSize = (PLPlateTypeSize *)[plateTypes objectAtIndex:[indexPath row]];
        [[[PLBasketStore sharedStore] plateBuilder] setPlateTypeSize:selectedPlateTypeSize];
    } else {  // Plate Size
        PLPlateSize *selectedSize = (PLPlateSize *)[plateSizes objectAtIndex:[indexPath row]];
        [[[PLBasketStore sharedStore] plateBuilder] setPlateSize:selectedSize];
    }
    [self reloadTableViewData];
}

- (void)fetchPlateTypesAndSides
{
    __weak PLSelectPlateSizeViewController *weakSelf = self;
    
    [[PLPlateStore sharedStore] getPlateSizesAndTypes:^(PLPlatesTypesAndSizes *plateTypesSize, NSError *err) {
        
        if (!err) {
            plateTypes = [plateTypesSize getTypes];
            plateSizes = [plateTypesSize getSizes];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self plateSizeTable] == tableView) {
        return [plateSizes count];
    } else {
        return [plateTypes count];
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
        PLPlateTypeSize *plateTypeSize = (PLPlateTypeSize *)[plateTypes objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[plateTypeSize typeName]];
        
        // Add the checkmark if a type has been set
        PLPlateTypeSize *currentType = [[[PLBasketStore sharedStore] plateBuilder] plateTypeSize];
        if ([currentType.typeId isEqualToString:[plateTypeSize typeId]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else {  // Plate Size
        PLPlateSize *plateSize = (PLPlateSize *)[plateSizes objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[plateSize name]];
        
        // Add the checkmark if a size has been set
        PLPlateSize *currentSize = [[[PLBasketStore sharedStore] plateBuilder] plateSize];
        if ([currentSize.id isEqualToString:plateSize.id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
    
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
//    }
//    
//    cell.layer.borderWidth = 1.0f;
//    cell.layer.borderColor = [[UIColor blackColor] CGColor];
//    cell.layer.masksToBounds = YES;
//    cell.layer.cornerRadius = 12.0f;
//    cell.layer.backgroundColor = [[UIColor grayColor] CGColor];
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.textLabel.textColor = [UIColor moneyGreenColor];
//    
//    if (tableView == [self plateTypeTable]) {  // Plate Type
//
//        [[cell textLabel] setText:[plateType objectAtIndex:[indexPath row]]];
//
//        // Add the checkmark if a type has been set
//        PlateType currentType = [[[PLBasketStore sharedStore] plateBuilder] type];
//        if (([indexPath row] == 0) && (currentType == OneMain)) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        } else if (([indexPath row] == 1) && (currentType == FourSides)) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//
//    } else {  // Plate Size
//
//        [[cell textLabel] setText:[plateSize objectAtIndex:[indexPath row]]];
//        
//        // Add the checkmark if a size has been set
//        PlateSize currentSize = [[[PLBasketStore sharedStore] plateBuilder] size];
//        if (([indexPath row] == 0) && (currentSize == Fit)) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        } else if (([indexPath row] == 1) && (currentSize == Ultra)) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        } else if (([indexPath row] == 2) && (currentSize == Kids)) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//
//    }
//    
//    return cell;
//    
//}

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
    [self fetchPlateTypesAndSides];
    [self setTitle:@"Sizes"];
//    if (!plateTypes) {
//        plateTypes = [[NSArray alloc]initWithObjects:@"1 Main with 2 Sides", @"4 Sides", nil];
//    }
//    
//    if (!plateSizes) {
//        plateSizes = [[NSArray alloc]initWithObjects:@"Fit", @"Ultra", @"Kids", nil];
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContinue:(id)sender {

    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
//    if  (([plate size] == UndefinedSize) || ([plate type] == UndefinedType)) {
    if  (([plate plateSize] == nil) || ([plate plateTypeSize] == nil)) {
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
        
        NSString *slug = [[[[PLBasketStore sharedStore] plateBuilder] plateTypeSize] typeSlug];
        if ([slug isEqualToString:OneMainTwoSides]) {
            [[self navigationController] pushViewController:[self mainsViewController] animated:YES];
        } else if ([slug isEqualToString:FourSides]) {
            [[self navigationController] pushViewController:[self sidesViewController] animated:YES];
        }
    }
}
@end







