//
//  PLPlateType.m
//  Plate
//
//  Created by emileleon on 1/24/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLPlatesTypesAndSizes.h"
#import "PLPlateTypeSize.h"

@implementation PLPlatesTypesAndSizes

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    if (plates == nil) {
        plates = [[NSMutableArray alloc]init];
    }

    NSDictionary *platesDict = [d objectForKey:@"plates"];
    for (NSDictionary *plateDict in platesDict) {
        PLPlateTypeSize *plate = [[PLPlateTypeSize alloc]init];
        [plate readFromJSONDictionary:plateDict];
        [plates addObject:plate];
    }
}

- (NSMutableArray *)getSizes
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    for (PLPlateTypeSize *plateType in plates) {
        for (PLPlateSize *size in plateType.sizes) {
            BOOL exists = false;
            for (PLPlateSize *resultSize in result) {
                if ([resultSize.slug isEqualToString:size.slug]) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                [result addObject:size];
            }
        }
    }
    
    return result;
}

- (NSMutableArray *)getTypes
{
    return plates;
}

//-(NSString *)getModifierIDForSize:(int)size type:(int)type
//{
//    if (type == OneMain) {
//        if (size == Fit) {
//            return @"1";
//        } else if (size == Ultra) {
//            return @"71";
//        } else if (size == Kids) {
//            return @"73";
//        }
//    } else if (type == FourSides) {
//        if (size == Fit) {
//            return @"2";
//        } else if (size == Ultra) {
//            return @"72";
//        } else if (size == Kids) {
//            return @"74";
//        }
//    }
//    return nil;
//}
@end
