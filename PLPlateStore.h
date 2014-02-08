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

@interface PLPlateStore : NSObject
{
    PLPlatesTypesAndSizes *plateTypesSizes;
    NSMutableArray *plateMenus;
    PLMenu *aLaCarteMenu;
    PLMenu *addOnsMenu;
}

+ (PLPlateStore *)sharedStore;
- (void)clearCache;

- (void)getPlateMenu:(PLPlateSize *)plateSize plateType:(PLPlateTypeSize *)plateTypeSize forBlock:(void (^)(PLMenu *menuResult, NSError *))block;
- (void)getAddOnMenu:(void (^)(PLMenu *menuResult, NSError *err))block;
- (void)getALaCarteMenu:(void (^)(PLMenu *menuResult, NSError *))block;
- (void)getPlateSizesAndTypes:(void (^)(PLPlatesTypesAndSizes *plateTypesSizes, NSError *err))block;
//- (void)getProductDetail:(PLMenuItem *)menuItem forBlock:(void (^)(PLMenuItem))

@end
