//
//  PLBasketStore.h
//  Plate
//
//  Created by emileleon on 12/23/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLALaCarteItem;
@class PLAddOnItem;
@class PLMenuItem;
@class PLPlate;

@interface PLBasketStore : NSObject

// Singleton object
+ (PLBasketStore *)sharedStore;

// These are items that the user has not yet confirmed adding to basket
@property (nonatomic, strong) NSMutableArray* alaCarteBuilder;
@property (nonatomic, strong) NSMutableArray* addOnBuilder;
@property (nonatomic, strong) PLPlate* plateBuilder;

// These are items that have been added to the basket
@property (nonatomic, strong) NSMutableArray* alaCarteItems;
@property (nonatomic, strong) NSMutableArray* addOns;
@property (nonatomic, strong) NSMutableArray* plates;

// These add items to the temporary *builders
-(int)addALaCarteItem:(PLALaCarteItem *)item;
-(int)removeALaCarteItem:(PLALaCarteItem *)itemI;
-(int)addAddOnItem:(PLAddOnItem *)item;
-(int)removeAddOnItem:(PLAddOnItem *)item;
-(void)setPlateType:(PlateType)plateType;
-(void)setPlateSize:(PlateSize)plateSize;
-(void)setPlateMain:(PLMenuItem *)mainEntree;
-(void)addPlateSide:(PLMenuItem *)newSide;
-(void)removePlateSide:(PLMenuItem *)sideToRemove;

// These move items from the builders to the basket
-(void)addPlateToBasket;
-(void)addALaCarteItemsToBasket;
-(void)addAddOnItemsToBasket;

// This resets the basket to empty
-(void)clearBasket;

// Helper methods
-(int)quantityOfAllItemsInBasket;
-(int)quantityOfItemInALaCarteBuilder:(PLALaCarteItem *)item;
-(int)quantityOfItemInAddOnBuilder:(PLAddOnItem *)item;
-(int)quantityOfSideInPlateBuilder:(PLMenuItem *)item;

-(int)quantityOfItemsInALaCarteBuilder;
-(int)quantityOfItemsInAddOnBuilder;

// Debugging helper
-(NSString *)printContentsOfBasket;

-(float)totalCostOfItemsInBasket;

@end
