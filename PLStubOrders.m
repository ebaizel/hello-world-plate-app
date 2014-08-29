//
//  PLStubOrders.m
//  Plate
//
//  Created by Emile Baizel on 8/9/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLStubOrders.h"
#import "PLOrder.h"

@implementation PLStubOrders

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        PLOrder *order1;
        PLOrder *order2;
        PLOrder *order3;
        
        order1.pickupDate = [[NSDate alloc]init];

        
        
        NSMutableArray *orders = [[NSMutableArray alloc]initWithObjects: order1, order2, order3, nil];
        [self setOrders:orders];

    }
    return self;
}

@end
