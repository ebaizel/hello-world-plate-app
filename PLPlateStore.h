//
//  PLPlateStore.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLMenu.h"
#import "PLMenuItem.h"
#import "PLPlatesTypesAndSizes.h"
#import "PLPlateSize.h"
#import "PLAccount.h"
#import "PLPayment.h"

@interface PLPlateStore : NSObject
{
    PLPlatesTypesAndSizes *plateTypesSizes;
    NSMutableArray *plateMenus;
    PLMenu *aLaCarteMenu;
    PLMenu *addOnsMenu;
    PLAccount *account;
    PLPayment *payment;
}

+ (PLPlateStore *)sharedStore;
- (void)clearCache;

// Account Management
- (void)login:(PLAccount *)pAccount forBlock:(void (^)(PLAccount *, NSError *))block;
- (void)logout:(void (^)(NSError *))block;
- (void)addPayment:(PLPayment *)pPayment forBlock:(void (^)(PLPayment *, NSError *))block;

// Menus and Ordering
- (void)getPlateMenu:(PLPlateSize *)plateSize plateType:(PLPlateTypeSize *)plateTypeSize forBlock:(void (^)(PLMenu *menuResult, NSError *))block;
- (void)getAddOnMenu:(void (^)(PLMenu *menuResult, NSError *err))block;
- (void)getALaCarteMenu:(void (^)(PLMenu *menuResult, NSError *))block;
- (void)getPlateSizesAndTypes:(void (^)(PLPlatesTypesAndSizes *plateTypesSizes, NSError *err))block;
//- (void)getProductDetail:(PLMenuItem *)menuItem forBlock:(void (^)(PLMenuItem))

@end
