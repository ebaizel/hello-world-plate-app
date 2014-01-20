//
//  PLOrderItem.m
//  Plate
//
//  Created by emileleon on 12/16/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLPlate.h"

@implementation PLPlate

-(id)init
{
    self=[super init];
    if(self) {
        self.sides = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
