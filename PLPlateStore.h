//
//  PLPlateStore.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLPlateStore : NSObject
{
    NSArray *mainDishes;
}

+ (PLPlateStore *)sharedStore;
- (void)getMains:(void (^)(NSArray *mains, NSError *err))block;


@end
