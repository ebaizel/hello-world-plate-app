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
}

+ (PLPlateStore *)sharedStore;
- (void)clearCache;
- (void)getMenu:(void (^)(PLMenu *menuResult, NSError *err))block;


@end
