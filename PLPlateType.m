//
//  PLPlateType.m
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLPlateType.h"
#import "PLPlateSize.h"

@implementation PLPlateType

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    self.name = [d objectForKey:@"name"];
    self.id = [[d objectForKey:@"id"] intValue];


    if (self.sizes == nil) {
        self.sizes = [[NSMutableArray alloc]init];
    }

    NSDictionary *sizesDict = [d objectForKey:@"sizes"];
    for (NSDictionary *sizeDict in sizesDict) {
        PLPlateSize *size = [[PLPlateSize alloc]init];
        [size readFromJSONDictionary:sizeDict];
        [[self sizes] addObject:size];
    }
}
@end
