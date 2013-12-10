//
//  PLMenuItem.m
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLMenuItem.h"

@implementation PLMenuItem

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setName:@"Menu Item Name"];
    //TODO: parse the json into the object
}

-(id)initWithName:(NSString *)itemName itemType:(int)type
{
    self = [super init];
    if (self) {
        [self setName:itemName];
    }
    return self;
}

@end
