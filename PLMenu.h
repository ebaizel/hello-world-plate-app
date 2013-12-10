//
//  PLMenu.h
//  Plate
//
//  Created by emileleon on 12/10/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface PLMenu : NSObject <JSONSerializable>

@property (nonatomic, strong) NSMutableArray *mains;
@property (nonatomic, strong) NSMutableArray *sides;
@property (nonatomic, strong) NSMutableArray *addons;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *menuDate;


@end
