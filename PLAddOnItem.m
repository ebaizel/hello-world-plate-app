//
//  PLAddOnItem.m
//  Plate
//
//  Created by emileleon on 1/16/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLAddOnItem.h"

@implementation PLAddOnItem

-(id)copyWithZone:(NSZone *)zone
{
    PLAddOnItem *another = (PLAddOnItem *)[super copyWithZone:zone];
    another.quantity = self.quantity;
    return another;
}

@end
