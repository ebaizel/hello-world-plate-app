//
//  PLMenuItem.m
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLMenuItem.h"

@implementation PLMenuItem

@synthesize name, plateId, description, allergies, isGlutenFree, isVegan, isVegetarian;

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setName:[d objectForKey:@"meta.name"]];

}

-(id)initWithName:(NSString *)itemName itemType:(MenuItemType)type itemId:(NSString *)itemId
{
    self = [super init];
    if (self) {
        [self setName:itemName];
        [self setPlateId:itemId];
        [self setItemType:type];
    }
    return self;
}

@end
