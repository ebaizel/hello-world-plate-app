//
//  PLItemViewController.h
//  Plate
//
//  Created by emileleon on 2/28/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLMenuItem;

@protocol ItemDetailDelegate <NSObject>

- (void) dismissItemDetailView;

@end

@interface PLItemDetailController : UIViewController
{
    PLMenuItem *menuItem;
}

- (id)initWithMenuItem:(PLMenuItem *)menuItem;
//- (void)setMenuItem:(PLMenuItem *)menuItem;

@property (weak, nonatomic) IBOutlet UIImageView *imageItem;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UITextView *textProductDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelVegan;
@property (weak, nonatomic) IBOutlet UILabel *labelVegetarian;
@property (weak, nonatomic) IBOutlet UILabel *labelGlutenFree;
@property (weak, nonatomic) IBOutlet UILabel *labelNutFree;
@property (weak, nonatomic) id<ItemDetailDelegate> delegate;
- (IBAction)dismissModal:(id)sender;

@end
