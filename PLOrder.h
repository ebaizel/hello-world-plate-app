//
//  PLOrder.h
//  Plate
//
//  Created by emileleon on 12/16/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CURBSIDE @"curbside";
#define INSTORE @"instore";

@interface PLOrder : NSObject

@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSString *pickupOption; //curbside, instore
@property (nonatomic, strong) NSString *instructions;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSArray *orderItems;
@property (nonatomic, strong) NSString *userId;

@end
