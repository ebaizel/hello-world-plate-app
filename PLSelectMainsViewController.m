//
//  PLSelectMainsViewController.m
//  Plate
//
//  Created by emileleon on 11/30/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectMainsViewController.h"
#import "PLSelectSidesViewController.h"

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
    
        if ([indexPath row] == 0) {
            [[cell textLabel] setText:@"Fish"];
        } else if ([indexPath row] == 1) {
            [[cell textLabel] setText:@"Tofurkey"];
        } else if ([indexPath row] == 2) {
            [[cell textLabel] setText:@"Eel Sandwich"];
        } else if ([indexPath row] == 3) {
            [[cell textLabel] setText:@"Tofu Enchiladas"];
        } else if ([indexPath row] == 4) {
            [[cell textLabel] setText:@"Pumpkin Casserole"];
        } else if ([indexPath row] == 5) {
            [[cell textLabel] setText:@"Chow Fun"];
        } else if ([indexPath row] == 6) {
            [[cell textLabel] setText:@"BBQ Ribs"];
        } else {
            [[cell textLabel] setText:@"Mayonnaise"];
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
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"My Title";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSString *string =@"Choose a main";
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}

#pragma INITIALIZERS

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Mains"];
    [[self tableMains] setTableHeaderView:nil];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContinue:(id)sender {
    self.sidesController = [[PLSelectSidesViewController alloc] init];
    [[self navigationController] pushViewController:[self sidesController] animated:YES];
}
@end
