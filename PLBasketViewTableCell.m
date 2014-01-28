//
//  PLBasketViewTableCell.m
//  Plate
//
//  Created by emileleon on 1/27/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLBasketViewTableCell.h"

@implementation PLBasketViewTableCell

-(void)setupDelegate:(id<BasketViewTableCellDelegate>)cellDelegate parentTable:(UITableView *)tableView
{
    if (self) {
        self.parentTableView = tableView;
        self.delegate = cellDelegate;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 12.0f;
        self.layer.backgroundColor = [[UIColor grayColor] CGColor];
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
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.delegate = nil;
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
}

- (IBAction)removeItem:(id)sender {
    [[self delegate] removeItemWithCell:self];
}

@end
