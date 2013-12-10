//
//  PLPlateStore.m
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLPlateStore.h"
#import "PLMenuItem.h"
#import "PLConnection.h"

@implementation PLPlateStore

- (void) getMains:(void (^)(NSArray *mains, NSError *err))block
{
    if (mainDishes) {
        block(mainDishes, nil);
    } else {
    
        NSMutableArray *results = [[NSMutableArray alloc]init];
        [results addObject:[[PLMenuItem alloc]initWithName:@"Pan Seared Chilean Sea Bass" itemType:MenuItemMain]];
        [results addObject:[[PLMenuItem alloc]initWithName:@"Kung Pao Chicken" itemType:MenuItemMain]];
        [results addObject:[[PLMenuItem alloc]initWithName:@"Peking Duck" itemType:MenuItemMain]];
        [results addObject:[[PLMenuItem alloc]initWithName:@"Fire Roasted Tofu" itemType:MenuItemMain]];
        [results addObject:[[PLMenuItem alloc]initWithName:@"Golden Quinoa Dumplings" itemType:MenuItemMain]];
        
        mainDishes = results;

        block(results, nil);
    }
}

+ (PLPlateStore *)sharedStore
{
    static PLPlateStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

@end