//
//  PLBaseOrderViewController.m
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLBaseOrderViewController.h"

@interface PLBaseOrderViewController ()

@end

@implementation PLBaseOrderViewController

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

    // Setup the background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg-tomatoes.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.edgesForExtendedLayout=UIRectEdgeNone;

    // Setup the navigation bar
    [[self navigationItem] setTitle:@"Create a Plate"];
    
    // Setup the bottom toolbar
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Continue" style:UIBarButtonItemStylePlain target:self action:@selector(actionContinue:)];
    [barButton setTitleTextAttributes:@{
                                        NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:24.0],
                                        NSForegroundColorAttributeName: [UIColor blackColor]
                                        } forState:UIControlStateNormal];
    self.toolbarItems = [NSArray arrayWithObjects: flexibleSpaceLeft, barButton, nil];
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

- (void)actionContinue:(id)sender
{
    // do nothing
}

@end
