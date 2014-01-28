//
//  PLALaCarteTableViewCell.h
//  Plate
//
//  Created by emileleon on 1/14/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALaCarteCellDelegate;

@interface PLMenuItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@property (assign, nonatomic) NSString *itemId;
@property (weak, nonatomic) UITableView *parentTableView;

@property (assign, nonatomic) id <ALaCarteCellDelegate> delegate;

-(void)setupDelegate:(id<ALaCarteCellDelegate>)delegate parentTable:(UITableView *)tableView;

@end

@protocol ALaCarteCellDelegate <NSObject>

@optional
- (int)addItemWithCell:(PLMenuItemTableViewCell *)cell;
- (int)removeItemWithCell:(PLMenuItemTableViewCell *)cell;

@end