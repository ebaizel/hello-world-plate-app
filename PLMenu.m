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
    
    if ([self menuType] == MenuTypePlate) {
    
        NSString *sizeSlug = [[self plateSize] slug];
        NSString *mainKey = [sizeSlug stringByAppendingString:@"-main"];
        NSString *sideKey = [sizeSlug stringByAppendingString:@"-side"];
        
        NSDictionary *mainKeys = [d objectForKey:mainKey];
        if (mainKeys && [mainKeys count] > 0) {
            NSMutableArray *modifiersArray = (NSMutableArray *)[mainKeys objectForKey:@"modifiers"];
            NSMutableArray *mainModifiers = [self parseModifiers:(modifiersArray)];
            [self setMains:mainModifiers];
        }

        NSDictionary *sideKeys = [d objectForKey:sideKey];
        if (sideKeys && [sideKeys count] > 0) {
            NSMutableArray *modifiersArray = (NSMutableArray *)[sideKeys objectForKey:@"modifiers"];
            NSMutableArray *sideModifiers = [self parseModifiers:(modifiersArray)];
            [self setSides:sideModifiers];
        }
    } else if ([self menuType] == MenuTypeALaCarte) {
        NSArray *menus = [d objectForKey:@"menus"];
        for (NSDictionary * menuDict in menus) {
            NSMutableArray *productsDicts = [menuDict objectForKey:@"products"];
            NSMutableArray *products = [self parseModifiers:productsDicts];
            NSString *slug = [menuDict objectForKey:@"slug"];
            if ([slug isEqualToString:@"main-entrees"]) {
                for (PLMenuItem *menuItem in products) {
                    [menuItem setItemType:MenuItemMain];
                }
                [self setMains:products];
            } else if ([slug isEqualToString:@"sides"]) {
                for (PLMenuItem *menuItem in products) {
                    [menuItem setItemType:MenuItemSide];
                }
                [self setSides:products];
            }
        }
    } else if ([self menuType] == MenuTypeAddOn) {
        NSArray *menus = [d objectForKey:@"menus"];
        [self setAddons:[[NSMutableArray alloc]init]];
        for (NSDictionary * menuDict in menus) {
            NSMutableArray *productsDicts = [menuDict objectForKey:@"products"];
            NSMutableArray *products = [self parseModifiers:productsDicts];
            [[self addons] addObjectsFromArray:products];
        }
    }
    
}

-(NSMutableArray *)parseModifiers:(NSMutableArray *)modifiersArray
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSDictionary *modifierDict in modifiersArray) {
        PLMenuItem *plmi = [[PLMenuItem alloc] init];
        [plmi setName:[modifierDict objectForKey:@"name"]];
        [plmi setSlug:[modifierDict objectForKey:@"slug"]];
        [plmi setPrice:[[modifierDict objectForKey:@"price"] floatValue]];
        
        NSDictionary *metaDict = [modifierDict objectForKey:@"meta"];
        [plmi setName:[metaDict objectForKey:@"name"]];
        [plmi setItemDescription:[metaDict objectForKey:@"description"]];
        [plmi setAllergies:[metaDict objectForKey:@"alergies"]];
        [plmi setIsGlutenFree:[[metaDict objectForKey:@"is_gluten_free"] boolValue]];
        [plmi setIsVegan:[[metaDict objectForKey:@"is_vegan"] boolValue]];
        [plmi setIsVegetarian:[[metaDict objectForKey:@"is_vegetarian"] boolValue]];
        [plmi setIngredients:[metaDict objectForKey:@"ingredients"]];
        [plmi setPlateId:(NSString *)[metaDict objectForKey:@"id"]];
        [plmi setImageURL:[metaDict objectForKey:@"image"]];
        
        [result addObject:plmi];
    }
    return result;
}

@end
