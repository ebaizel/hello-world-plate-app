//
//  PLPlateType.h
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
@class PLPlateSize;

@interface PLPlateType : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int id;
@property (nonatomic, strong) NSMutableArray *sizes;

@end
