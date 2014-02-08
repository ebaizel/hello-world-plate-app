//
//  PLPlateType.h
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
#import "PLPlateSize.h"

@interface PLPlatesTypesAndSizes : NSObject <JSONSerializable>
{
    NSMutableArray *plates; //array of PLPlateTypeSize
}

- (NSMutableArray *)getSizes;
- (NSMutableArray *)getTypes;
//- (NSString *)getModifierIDForSize:(int)size type:(int)type;
@end
