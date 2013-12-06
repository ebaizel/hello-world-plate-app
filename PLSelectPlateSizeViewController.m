//
//  PLPlateCreate10Controller.m
//  Plate
//
//  Created by emileleon on 11/27/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectPlateSizeViewController.h"
#import "PLSelectMainsViewController.h"

@interface PLSelectPlateSizeViewController ()

@end

@implementation PLSelectPlateSizeViewController

@synthesize mainsViewController;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self plateSizeTable] == tableView) {
        return [plateSize count];
    } else {
        return [plateType count];
    }
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
    
    if ([self plateSizeTable] == tableView) {
        [[cell textLabel] setText:[plateSize objectAtIndex:[indexPath row]]];
    } else {
        [[cell textLabel] setText:[plateType objectAtIndex:[indexPath row]]];
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
    [[self navigationController] pushViewController:[self mainsViewController] animated:YES];
}
@end
