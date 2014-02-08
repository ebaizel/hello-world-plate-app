//
//  PLPlateSize.m
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLPlateSize.h"

@implementation PLPlateSize

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    self.slug = [d objectForKey:@"slug"];
    self.price = [[d objectForKey:@"price"] floatValue];
    self.id = [[d objectForKey:@"id"] stringValue];
    self.name = [d objectForKey:@"name"];
}

@end
