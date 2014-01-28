//
//  PLOrderItem.h
//  Plate
//
//  Created by emileleon on 12/16/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLMenuItem.h"
#import "PLPlateType.h"
#import "PLPlateSize.h"

@interface PLPlate : NSObject

@property (nonatomic, assign) PlateType type; //onemain, foursides
@property (nonatomic, assign) PlateSize size; //fit, ultra
//@property (nonatomic, strong) PLPlateType *type;
//@property (nonatomic, strong) PLPlateSize *size;
@property (nonatomic, strong) PLMenuItem *main;
@property (nonatomic, strong) NSMutableArray *sides;  //  Array of PLMenuItems

@end
