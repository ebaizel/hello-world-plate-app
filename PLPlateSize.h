//
//  PLPlateSize.h
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface PLPlateSize : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *name; //fit, ultra
@property (nonatomic) float price;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *slug;
@end
