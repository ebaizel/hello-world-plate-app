//
//  PLOrderItem.h
//  Plate
//
//  Created by emileleon on 12/16/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLOrderItem : NSObject

#define ONEMAIN @"onemain"
#define FOURSIDES @"foursides"
#define ADDONS @"addons"
#define ALACARTE @"alacarte"
#define SIZEFIT @"fit"
#define SIZEULTRA @"ultra"

@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSArray *itemIds;
@property (nonatomic, strong) NSString *type; //onemain, addons, foursides, alacarte
@property (nonatomic, strong) NSString *size; //fit, ultra
@end
