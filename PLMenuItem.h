//
//  PLMenuItem.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

typedef enum {
    MenuItemMain,
    MenuItemSide
} MenuItemType;

@interface PLMenuItem : NSObject <JSONSerializable>
{
    MenuItemType itemType;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *plateId;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *allergies;
@property (assign) BOOL isGlutenFree;
@property (assign) BOOL isVegan;
@property (assign) BOOL isVegetarian;

-(id)initWithName:(NSString *)itemName itemType:(int)type;

@end
