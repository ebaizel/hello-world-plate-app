//
//  PLMenuItem.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MenuItemMain,
    MenuItemSide
} MenuItemType;

@interface PLMenuItem : NSObject
{
    MenuItemType itemType;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *plateId;

-(id)initWithName:(NSString *)itemName itemType:(int)type;

@end
