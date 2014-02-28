//
//  PLALaCarteTableViewCell.m
//  Plate
//
//  Created by emileleon on 1/14/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLMenuItemTableViewCell.h"

@implementation PLMenuItemTableViewCell

- (IBAction)viewItemDetail:(id)sender {
    [[self delegate]displayItemDetail:self];
}

-(void)setupDelegate:(id<MenuItemTableViewCellDelegate>)cellDelegate parentTable:(UITableView *)tableView
{
    if (self) {
        self.parentTableView = tableView;
        self.delegate = cellDelegate;
//        self.layer.borderWidth = 1.0f;
//        self.layer.borderColor = [[UIColor blackColor] CGColor];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 12.0f;
//        self.layer.backgroundColor = [[UIColor grayColor] CGColor];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.delegate = nil;
}

- (IBAction)increaseQuantity:(id)sender {
    int q = [[self delegate] addItemWithCell:self];
    self.quantityLabel.text = [NSString stringWithFormat:@"%d", q];
}

- (IBAction)decreaseQuantity:(id)sender {
    int q = [[self delegate] removeItemWithCell:self];
    self.quantityLabel.text = [NSString stringWithFormat:@"%d", q];
}
@end
