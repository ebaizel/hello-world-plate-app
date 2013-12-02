//
//  PLHomeViewController.m
//  Plate
//
//  Created by emileleon on 11/26/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLHomeViewController.h"
#import "PLSelectPlateSizeViewController.h"

@interface PLHomeViewController ()

@end

@implementation PLHomeViewController


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if ([indexPath row] == 0) {
//        [[self view] addSubview:[[self selectSizeController] view]];
        [[self navigationController] pushViewController:[self selectSizeController] animated:YES];
    } else if ([indexPath row] == 1) {

    } else {

    }
    
}

-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
 
    if ([indexPath row] == 0) {
        [[cell textLabel] setText:@"Create a Plate"];
    } else if ([indexPath row] == 1) {
        [[cell textLabel] setText:@"A la Carte"];
    } else {
        [[cell textLabel] setText:@"Add ons"];
    }
    
    return cell;

}

#pragma INIT METHODS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Plate";
        [self setSelectSizeController:[[PLSelectPlateSizeViewController alloc] init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil];

    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
