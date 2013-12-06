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
        return 3;
    } else {
        return 2;
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
        
        if ([indexPath row] == 0) {
            [[cell textLabel] setText:@"Fit"];
        } else if ([indexPath row] == 1) {
            [[cell textLabel] setText:@"Ultra"];
        } else {
            [[cell textLabel] setText:@"Kid"];
        }
        
    } else {
        
        if ([indexPath row] == 0) {
            [[cell textLabel] setText:@"1 Main and 2 Sides"];
        } else if ([indexPath row] == 1) {
            [[cell textLabel] setText:@"4 Sides"];
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Sizes"];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
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
