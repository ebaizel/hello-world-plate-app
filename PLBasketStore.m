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
#import "PLPlateSize.h"

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
        addOnItem = [item copy];
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
    
    for (addOnItem in [self addOnBuilder]) {
        if ([[item plateId] isEqualToString:[addOnItem plateId]]) {
            break;
        }
    }
    
    if (addOnItem == nil) {
        return 0;
    }
    
    addOnItem.quantity--;
    if (addOnItem.quantity <= 0) {
        [[self addOnBuilder] removeObject:addOnItem];
        return 0;
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
        acItem = [item copy];
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
    
    for (acItem in [self alaCarteBuilder]) {
        if ([[item plateId] isEqualToString:[acItem plateId]]) {
            break;
        }
    }
    
    if (acItem == nil) {
        return 0;
    }
    
    acItem.quantity--;
    if (acItem.quantity <= 0) {
        [[self alaCarteBuilder] removeObject:acItem];
        return 0;
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
    // Iterate over the items in the builder.  If they exist, only update the quantity
    for (PLALaCarteItem *builderItem in [self alaCarteBuilder]) {
        BOOL itemExists = false;
        for (PLALaCarteItem *item in [self alaCarteItems]) {
            if ([builderItem plateId] == [item plateId]) {
                item.quantity = item.quantity + builderItem.quantity;
                itemExists = true;
                break;
            }
        }
        if (!itemExists) {
            [[self alaCarteItems] addObject:[builderItem copy]];
        }
    }
        
    self.alaCarteBuilder = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BasketUpdated" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ALaCarteBuilderEmptied" object:self];
}

-(void)addAddOnItemsToBasket
{
    // Iterate over the items in the builder.  If they exist, only update the quantity
    for (PLAddOnItem *builderItem in [self addOnBuilder]) {
        BOOL itemExists = false;
        for (PLAddOnItem *item in [self addOns]) {
            if ([builderItem plateId] == [item plateId]) {
                item.quantity = item.quantity + builderItem.quantity;
                itemExists = true;
                break;
            }
        }
        if (!itemExists) {
            [[self addOns] addObject:[builderItem copy]];
        }
    }

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

-(void)setPlateType2:(PlateType)plateType
{
    [[self plateBuilder] setType:plateType];
}

-(void)setPlateSize2:(PlateSize)plateSize
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
    NSString *slug = [[[[PLBasketStore sharedStore] plateBuilder] plateTypeSize] typeSlug];
    if ([slug isEqualToString:OneMainTwoSides]) {
        numSides = 2;
    } else if ([slug isEqualToString:FourSides]) {
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
            return [aLaCarteItem quantity];
        }
    }
    return 0;
}

-(int)quantityOfItemInAddOnBuilder:(PLAddOnItem *)item
{
    for (PLAddOnItem *addOnItem in [self addOnBuilder]) {
        if ([[addOnItem plateId] isEqualToString:[item plateId]]) {
            return [addOnItem quantity];
        }
    }
    return 0;
}

-(int)quantityOfSideInPlateBuilder:(PLMenuItem *)item
{
    int count = 0;
    for (PLMenuItem *side in [[self plateBuilder] sides]) {
        if ([side plateId] == [item plateId]) {
            count++;
        }
    }
    return count;
}

-(int)quantityOfItemsInALaCarteBuilder{
    int count = 0;
    for (PLALaCarteItem *aLaCarteItem in [self alaCarteBuilder]) {
        count += [aLaCarteItem quantity];
    }
    return count;
}

-(int)quantityOfItemsInAddOnBuilder{
    int count = 0;
    for (PLAddOnItem *addOnItem in [self addOnBuilder]) {
        count += [addOnItem quantity];
    }
    return count;
}

-(NSString *)printContentsOfBasket
{
    NSString *summary = @"";
    // Plates
    if ([[self plates] count] > 0) {
        summary = [summary stringByAppendingString:@"PLATES:\n"];
        for (PLPlate *plate in [self plates]) {
            if ([plate main] != nil) {
                summary = [summary stringByAppendingString:@"Main:\n"];
                summary = [summary stringByAppendingString:[[plate main] name]];
                summary = [summary stringByAppendingString:@"\n"];
            }
            summary = [summary stringByAppendingString:@"Sides:\n"];
            for (PLMenuItem *side in [plate sides]) {
                summary = [summary stringByAppendingString:[side name]];
                summary = [summary stringByAppendingString:@"\n"];
            }
        }
    }
    
    // Add Ons
    if ([[self addOns] count] > 0) {
        summary = [summary stringByAppendingString:@"ADD ONS:\n"];
        for (PLAddOnItem *item in [self addOns]) {
            NSString *addOnSummary = [NSString stringWithFormat:@"%@: Qty %d\n", [item name], [item quantity]];
            summary = [summary stringByAppendingString:addOnSummary];
        }
    }
    // A La Carte
    if ([[self alaCarteItems] count] > 0) {
        summary = [summary stringByAppendingString:@"A LA CARTE:\n"];
        for (PLALaCarteItem *item in [self alaCarteItems]) {
            NSString *alacSummary = [NSString stringWithFormat:@"%@: Qty %d\n", [item name], [item quantity]];
            summary = [summary stringByAppendingString:alacSummary];
        }
    }
    
    if ([summary length] == 0) {
        summary = [NSString stringWithFormat:@"Basket is empty"];
    }
    
    return summary;
}


-(float)totalCostOfItemsInBasket
{
    float total = 0.0;
    for (PLPlate *plate in [self plates]) {
        total += [[plate plateSize] price];
    }
    
    for (PLALaCarteItem *item in [self alaCarteItems]) {
        total += [item price] * [item quantity];
    }

    for (PLAddOnItem *item in [self addOns]) {
        total += [item price] * [item quantity];
//        total += (2 * [item quantity]);
    }

    return total;
}

-(int)quantityOfAllItemsInBasket
{
    int count = 0;
    count += [[self plates] count];
    for (PLALaCarteItem *item in [self alaCarteItems]) {
        count += [item quantity];
    }
    for (PLAddOnItem *item in [self addOns]) {
        count += [item quantity];
    }

    return count;
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
