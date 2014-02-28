//
//  PLMenuItem.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface PLMenuItem : NSObject <JSONSerializable, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *plateId;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *allergies;
@property (nonatomic, strong) NSString *ingredients;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, assign) float price;
@property (nonatomic) int quantity;
@property (nonatomic) MenuItemType itemType;
@property (assign) BOOL isGlutenFree;
@property (assign) BOOL isVegan;
@property (assign) BOOL isVegetarian;

-(id)initWithName:(NSString *)itemName itemType:(MenuItemType)type itemId:(NSString *)itemId;

@end
