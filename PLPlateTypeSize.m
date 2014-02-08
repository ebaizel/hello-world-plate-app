//
//  PLPlateTypeSize.m
//  Plate
//
//  Created by emileleon on 2/6/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLPlateTypeSize.h"
#import "PLPlateSize.h"

@implementation PLPlateTypeSize

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    self.typeName = [d objectForKey:@"name"];
    self.typeSlug = [d objectForKey:@"slug"];
    self.typeId = [[d objectForKey:@"id"] stringValue];

    NSDictionary *sizesDict = [d objectForKey:@"sizes"];
    
    if (!self.sizes) {
        self.sizes = [[NSMutableArray alloc]init];
    }
    
    for (NSDictionary *sizeDict in sizesDict) {
        PLPlateSize *size = [[PLPlateSize alloc]init];
        [size readFromJSONDictionary:sizeDict];
        [self.sizes addObject:size];
    }
}

@end
