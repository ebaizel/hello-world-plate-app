//
//  PLPlateCreate10Controller.m
//  Plate
//
//  Created by emileleon on 11/27/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLSelectPlateSizeViewController.h"
#import "PLSelectMainsViewControllerORIG.h"

@interface PLSelectPlateSizeViewController ()

@end

@implementation PLSelectPlateSizeViewController

@synthesize mainsViewController;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath row] == 0) {
//        [[self view] addSubview:[[self selectSizeController] view]];
//        [[self navigationController] pushViewController:[self selectSizeController] animated:YES];
    } else if ([indexPath row] == 1) {
        
    } else {
        
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
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self navigationItem] setTitle:@"Create a Plate"];
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        self.mainsViewController = [[PLSelectMainsViewControllerORIG alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.edgesForExtendedLayout=UIRectEdgeNone;

    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Sizes"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayMains:(id)sender {
    [[self navigationController] pushViewController:[self mainsViewController] animated:YES];
}
@end
