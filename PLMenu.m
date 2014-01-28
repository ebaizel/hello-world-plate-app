//
//  PLMenu.m
//  Plate
//
//  Created by emileleon on 12/10/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLMenu.h"
#import "PLMenuItem.h"

@implementation PLMenu

@synthesize mains, sides, addons, location, menuDate;

+(NSString *)generateRandomID
{
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 20; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    NSDictionary *response = [d objectForKey:@"response"];
    NSDictionary *mainModifiers = [response valueForKeyPath:@"3.modifiers"];
    if (mainModifiers) {

        if (!mains) {
            mains = [[NSMutableArray alloc]init];
        }
        
        for (NSString *key in mainModifiers) {

            NSDictionary *mainModifier = [mainModifiers objectForKey:key];
            NSDictionary *mainItem = [mainModifier objectForKey:@"meta"];

            PLMenuItem *plmi = [[PLMenuItem alloc] init];
            [plmi setName:[mainModifier objectForKey:@"name"]];
            [plmi setPlateId:[PLMenu generateRandomID]];  // probably need to remove this
// ### UNCOMMENT BELOW WHEN META IS WORKING
//            [plmi setName:[mainItem objectForKey:@"name"]];
//            [plmi setDescription:[mainItem objectForKey:@"description"]];
//            [plmi setAllergies:[mainItem objectForKey:@"alergies"]];
//            [plmi setIsGlutenFree:[[mainItem objectForKey:@"is_gluten_free"] boolValue]];
//            [plmi setIsVegan:[[mainItem objectForKey:@"is_vegan"] boolValue]];
//            [plmi setIsVegetarian:[[mainItem objectForKey:@"is_vegetarian"] boolValue]];
            
            [mains addObject:plmi];
        }
    }
    
    NSDictionary *sideModifiers = [response valueForKeyPath:@"4.modifiers"];
    if (sideModifiers) {
        
        if (!sides) {
            sides = [[NSMutableArray alloc]init];
        }
        
        for (NSString *key in sideModifiers) {
            NSDictionary *sideItem = [sideModifiers objectForKey:key];
            PLMenuItem *plmi = [[PLMenuItem alloc] init];
            [plmi setName:[sideItem objectForKey:@"name"]];
            [plmi setPlateId:[PLMenu generateRandomID]];            
            [sides addObject:plmi];
        }
    }
    
}

@end
