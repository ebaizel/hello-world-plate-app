//
//  PLPlateTypeSize.h
//  Plate
//
//  Created by emileleon on 2/6/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface PLPlateTypeSize : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *typeSlug;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSMutableArray *sizes;  // array of PLPlateSize

//@property (nonatomic, strong) NSString *sizeName;
//@property (nonatomic, strong) NSString *sizeSlug;
//@property (nonatomic, strong) NSString *typeId;
//@property (nonatomic, strong) NSString *modifierId;
//@property (nonatomic, assign) float price;
@end
