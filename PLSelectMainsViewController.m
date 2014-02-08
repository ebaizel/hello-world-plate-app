//
//  PLSelectMainsViewController.m
//  Plate
//
//  Created by emileleon on 11/30/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectMainsViewController.h"
#import "PLSelectSidesViewController.h"
#import "PLPlateStore.h"
#import "PLMenu.h"
#import "PLBasketStore.h"
#import "PLPlate.h"
#import "Colours.h"
#import "PLPlateTypeSize.h"
#import "PLPlateSize.h"

@interface PLSelectMainsViewController ()

@end

@implementation PLSelectMainsViewController

@synthesize sidesController;

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
    cell.textLabel.textColor = [UIColor moneyGreenColor];
    [[cell textLabel] setText:[[mains objectAtIndex:[indexPath row]] name]];
    
    if ((PLMenuItem *)[mains objectAtIndex:[indexPath row]] == [[[PLBasketStore sharedStore] plateBuilder] main]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
    
}

-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[PLBasketStore sharedStore] setPlateMain:[mains objectAtIndex:[indexPath row]]];
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mains count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)fetchMains
{
    
    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    __weak PLSelectMainsViewController *weakSelf = self;
    
    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
    [[PLPlateStore sharedStore] getPlateMenu:[plate plateSize] plateType:[plate plateTypeSize] forBlock:^(PLMenu *menuResult, NSError *err) {
        
        [[weakSelf navigationItem] setTitleView:currentTitleView];
        
        if (!err) {
            mains = [menuResult mains];
            [[weakSelf tableMains] reloadData];
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


#pragma INITIALIZERS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableMains reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Mains"];
    [[self tableMains] setTableHeaderView:nil];
    [self fetchMains];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContinue:(id)sender {
    
    PLPlate *plate = [[PLBasketStore sharedStore] plateBuilder];
    if  ([plate main] == nil) {
        NSString *msg = [NSString stringWithFormat:@"Select a Main"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                        message:@"Please select a main entree"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    } else {
        self.sidesController = [[PLSelectSidesViewController alloc] init];
        [[self navigationController] pushViewController:[self sidesController] animated:YES];
    }
}
@end
