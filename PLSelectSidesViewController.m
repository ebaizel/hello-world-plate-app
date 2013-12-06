//
//  PLSelectSidesViewController.m
//  Plate
//
//  Created by emileleon on 12/1/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectSidesViewController.h"
#import "PLOrderSummaryViewController.h"

@interface PLSelectSidesViewController ()

@end

@implementation PLSelectSidesViewController

@synthesize orderSummaryController;

#pragma mark - Table view data source

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

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SidesViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SidesViewCell"];
    }
    
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 12.0f;
    cell.layer.backgroundColor = [[UIColor grayColor] CGColor];

    [[cell textLabel] setText:[sides objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sides";
    self.orderSummaryController = [[PLOrderSummaryViewController alloc]init];
    
    sides = [[NSArray alloc]initWithObjects:@"Broccolini", @"Mashed Potatoes", @"Moroccan Cauliflower", @"Pickled Beets",
             @"Deviled Eggs", @"Kool Aid, no sugar", @"Peanut Butter, no jelly", @"Ham, no burger", nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContinue:(id)sender {
    [[self navigationController] pushViewController:[self orderSummaryController] animated:YES];
}
@end
