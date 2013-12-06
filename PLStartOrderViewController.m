//
//  PLHomeViewController.m
//  Plate
//
//  Created by emileleon on 11/26/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLStartOrderViewController.h"
#import "PLSelectPlateSizeViewController.h"

@interface PLStartOrderViewController ()

@end

@implementation PLStartOrderViewController


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if ([indexPath row] == 0) {
        [[self navigationController] pushViewController:[self selectSizeController] animated:YES];
    } else if ([indexPath row] == 1) {

    } else {

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [startingOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 12.0f;
    cell.layer.backgroundColor = [[UIColor grayColor] CGColor];

    [[cell textLabel] setText:[startingOptions objectAtIndex:[indexPath row]]];
    
    return cell;

}

#pragma INIT METHODS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!startingOptions) {
        startingOptions = [[NSArray alloc]initWithObjects:@"Create a Plate", @"A la carte", @"Add ons", nil];
    }

    [self setTitle:@"Order"];

    PLSelectPlateSizeViewController *plpsvc = [[PLSelectPlateSizeViewController alloc]init];
    plpsvc.hidesBottomBarWhenPushed = YES;
    [self setSelectSizeController:plpsvc];
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

@end
