//
//  PLBasketViewTableCell.h
//  Plate
//
//  Created by emileleon on 1/27/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasketViewTableCellDelegate;

@interface PLBasketViewTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *side1Label;
@property (weak, nonatomic) IBOutlet UILabel *side2Label;
@property (weak, nonatomic) IBOutlet UILabel *side3Label;
@property (weak, nonatomic) IBOutlet UILabel *side4Label;
@property (weak, nonatomic) IBOutlet UILabel *plateSizeLabel;

@property (assign, nonatomic) NSString *itemId;
@property (weak, nonatomic) UITableView *parentTableView;
@property (assign, nonatomic) BasketItemType itemType;
@property (assign, nonatomic) int itemIndex;

@property (assign, nonatomic) id <BasketViewTableCellDelegate> delegate;

- (IBAction)removeItem:(id)sender;

-(void)setupDelegate:(id<BasketViewTableCellDelegate>)delegate parentTable:(UITableView *)tableView;

@end

@protocol BasketViewTableCellDelegate <NSObject>

@optional
- (void)removeItemWithCell:(PLBasketViewTableCell *)cell;


@end
