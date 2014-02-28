//
//  PLItemViewController.m
//  Plate
//
//  Created by emileleon on 2/28/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLItemDetailController.h"
#import "PLMenuItem.h"

@interface PLItemDetailController ()

@end

@implementation PLItemDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMenuItem:(PLMenuItem *)pMenuItem
{
    self = [super initWithNibName:@"PLItemDetailController" bundle:nil];
    if (self) {
        menuItem = pMenuItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelProductName.text = menuItem.name;
    _labelVegan.text = [NSString stringWithFormat:@"Vegan: %@", menuItem.isVegan ? @"Yes":@"No"];
    _labelVegetarian.text = [NSString stringWithFormat:@"Vegetarian: %@", menuItem.isVegetarian ? @"Yes":@"No"];
    _labelGlutenFree.text = [NSString stringWithFormat:@"Gluten Free: %@", menuItem.isGlutenFree ? @"Yes":@"No"];
    if (!menuItem.itemDescription || !menuItem.itemDescription.length>0) {
        _textProductDescription.text = @"product description";
    } else {
        _textProductDescription.text = menuItem.itemDescription;;
    }
    [_imageItem setImage:[UIImage imageNamed:@"ginger-pork.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissModal:(id)sender {
    [[self delegate] dismissItemDetailView];
}
@end
