//
//  PLBasketStore.m
//  Plate
//
//  Created by emileleon on 12/23/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLBasketStore.h"
#import "PLALaCarteItem.h"
#import "PLPlate.h"
#import "PLAddOnItem.h"

@implementation PLBasketStore

-(int)addAddOnItem:(PLAddOnItem *)item
{
    PLAddOnItem *addOnItem = nil;
    for (PLAddOnItem *basketItem in [self addOnBuilder]) {
        if ([[item plateId] isEqualToString:[basketItem plateId]]) {
            addOnItem = basketItem;
            break;
        }
    }

    if (addOnItem == nil) {
        addOnItem = item;
        addOnItem.quantity = 0;
        [[[PLBasketStore sharedStore] addOnBuilder] addObject:addOnItem];
    }
    
    addOnItem.quantity++;
    if (addOnItem.quantity > 5) {
        addOnItem.quantity = 5;
    }
    
    return addOnItem.quantity;
}

-(int)removeAddOnItem:(PLAddOnItem *)item
{
    PLAddOnItem *addOnItem = nil;
    
    for (PLAddOnItem *basketItem in [self addOnBuilder]) {
        if ([[item plateId] isEqualToString:[basketItem plateId]]) {
            addOnItem = basketItem;
            break;
        }
    }
    
    if (addOnItem == nil) {
        return 0;
    }
    
    addOnItem.quantity--;
    if (addOnItem.quantity < 0) {
        addOnItem.quantity = 0;
    }
    
    return addOnItem.quantity;
}

-(int)addALaCarteItem:(PLALaCarteItem *)item
{
    PLALaCarteItem *acItem = nil;
    
    for (PLALaCarteItem *basketItem in [self alaCarteBuilder]) {
        if ([[item plateId] isEqualToString:[basketItem plateId]]) {
            acItem = basketItem;
            break;
        }
    }
    
    if (acItem == nil) {
        acItem = item;
        acItem.quantity = 0;
        [[[PLBasketStore sharedStore] alaCarteBuilder] addObject:acItem];
    }
    
    acItem.quantity++;
    if (acItem.quantity > 5) {
        acItem.quantity = 5;
    }
    
    return acItem.quantity;

}

-(int)removeALaCarteItem:(PLALaCarteItem *)item
{
    PLALaCarteItem *acItem = nil;
    
    for (PLALaCarteItem *basketItem in [self alaCarteBuilder]) {
        if ([[item plateId] isEqualToString:[basketItem plateId]]) {
            acItem = basketItem;
            break;
        }
    }
    
    if (acItem == nil) {
        return 0;
    }
    
    acItem.quantity--;
    if (acItem.quantity < 0) {
        acItem.quantity = 0;
    }
    
    return acItem.quantity;
}

-(void)addPlateToBasket
{
    [[self plates] addObject:[self plateBuilder]];
    self.plateBuilder = [[PLPlate alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BasketUpdated" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlateBuilderEmptied" object:self];
}

-(void)addALaCarteItemsToBasket
{
    self.alaCarteItems = [[self.alaCarteItems arrayByAddingObjectsFromArray:[self alaCarteBuilder]] mutableCopy];
    self.alaCarteBuilder = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BasketUpdated" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ALaCarteBuilderEmptied" object:self];
}

-(void)addAddOnItemsToBasket
{
    self.addOns = [[self.addOns arrayByAddingObjectsFromArray:[self addOnBuilder]] mutableCopy];
    self.addOnBuilder = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BasketUpdated" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddOnBuilderEmptied" object:self];
}

-(void)clearBasket
{
    [self setAlaCarteBuilder:[[NSMutableArray alloc] init]];
    [self setAddOnBuilder:[[NSMutableArray alloc]init]];
    [self setPlateBuilder:[[PLPlate alloc]init]];
    
    [self setAlaCarteItems:[[NSMutableArray alloc]init]];
    [self setAddOns:[[NSMutableArray alloc]init]];
    [self setPlates:[[NSMutableArray alloc]init]];
}

#pragma Plate Builder helper methods

-(void)setPlateType:(PlateType)plateType
{
    [[self plateBuilder] setType:plateType];
}

-(void)setPlateSize:(PlateSize)plateSize
{
    [[self plateBuilder] setSize:plateSize];
}

-(void)setPlateMain:(PLMenuItem *)mainEntree
{
    [[self plateBuilder] setMain:mainEntree];
}

-(void)addPlateSide:(PLMenuItem *)newSide
{
    // Make sure we do not exceed the allowed number of sides

    int numSides = 0;
    if ([[self plateBuilder] type] == OneMain) {
        numSides = 2;
    } else if ([[self plateBuilder] type] == FourSides) {
        numSides = 4;
    }
    
    NSMutableArray *sides = [[self plateBuilder] sides];
    
    if ([sides count] >= numSides) {
        // remove a side; right now we just remove the earliest one added
        [sides removeObjectAtIndex:0];
    }
    
    [sides addObject:newSide];
}

-(void)removePlateSide:(PLMenuItem *)sideToRemove
{
    // Remove the first occurrence of this item in the 'sides' array
    int currIndex = 0;
    NSMutableArray *sides = [[self plateBuilder] sides];
    for (int i =0; i < [sides count]; i++) {
        PLMenuItem *side = [sides objectAtIndex:currIndex];
        if (side == sideToRemove) {
            [sides removeObjectAtIndex:currIndex];
            break;
        }
    }
}

#pragma Helper methods
-(int)quantityOfItemInALaCarteBuilder:(PLALaCarteItem *)item
{
    for (PLALaCarteItem *aLaCarteItem in [self alaCarteBuilder]) {
        if ([[aLaCarteItem plateId] isEqualToString:[item plateId]]) {
            return [item quantity];
        }
    }
    return 0;
}

-(int)quantityOfItemInAddOnBuilder:(PLAddOnItem *)item
{
    for (PLAddOnItem *addOnItem in [self addOnBuilder]) {
        if ([[addOnItem plateId] isEqualToString:[item plateId]]) {
            return [item quantity];
        }
    }
    return 0;
}

-(int)quantityOfSideInPlateBuilder:(PLMenuItem *)item
{
    int count = 0;
    for (PLMenuItem *side in [[self plateBuilder] sides]) {
        if (side == item) {
            count++;
        }
    }
    return count;
}


-(float)totalCostOfItemsInBasket
{
    float total = 0.0;
    total = total + (1.0 * [[self plates] count]);
    total = total + (0.1 * [[self addOns] count]);
    total = total + (0.01 * [[self alaCarteItems] count]);
    return total;
}

#pragma Singleton setup

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+ (PLBasketStore *)sharedStore
{
    static PLBasketStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
        [sharedStore clearBasket];
    }
    return sharedStore;
}
@end
