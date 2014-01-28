//
//  PLPlateStore.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLMenu.h"

@interface PLPlateStore : NSObject
{
    PLMenu *menu;
    NSMutableArray *plates;
}

+ (PLPlateStore *)sharedStore;
- (void)clearCache;
- (void)getMenu:(void (^)(PLMenu *menuResult, NSError *err))block;
- (void)getPlateMenu:(int)sizeTypeId forBlock:(void (^)(PLMenu *menuResult, NSError *))block;
- (void)getAddOnMenu:(void (^)(PLMenu *menuResult, NSError *err))block;
- (void)getALaCarteMenu:(void (^)(PLMenu *menuResult, NSError *))block;
- (void)getPlateSizesAndTypes:(void (^)(NSMutableArray *plates, NSError *err))block;
- (int)getPlateSizeTypeId:(int)typeId sizeId:(int)sizeId;

@end
