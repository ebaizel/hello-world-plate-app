//
//  PLPlateType.h
//  Plate
//
//  Created by emileleon on 2/6/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLPlateType : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSMutableArray *sizes;
@end
