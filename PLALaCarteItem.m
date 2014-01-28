//
//  PLALaCarteItem.m
//  Plate
//
//  Created by emileleon on 1/14/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLALaCarteItem.h"

@implementation PLALaCarteItem

@synthesize quantity;

-(id)copyWithZone:(NSZone *)zone
{
    PLALaCarteItem *another = (PLALaCarteItem *)[super copyWithZone:zone];
//    another.quantity = 5;
    
//    [another setQuantity:self.quantity];
    another.quantity = self.quantity;
    return another;
}
@end
