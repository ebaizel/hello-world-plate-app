//
//  PLPlateStore.m
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLPlateStore.h"
#import "PLMenuItem.h"
#import "PLConnection.h"
#import "PLMenu.h"
#import "PLPlatesTypesAndSizes.h"
#import "PLPlateTypeSize.h"

#ifdef DEBUG
    #define BASEURL @"http://ep2.gulosolutions.com/"
#else
    #define BASEURL @"http://ep2.gulosolutions.com/"
#endif

@implementation PLPlateStore

//- (int)getPlateSizeTypeId:(int)typeId sizeId:(int)sizeId
//{
//    if (!plates) { return 0; }
//    int result = 0;
//    for (PLPlateType *plateType in plates) {
//        if (plateType.id == typeId) {
//            for (PLPlateSize *plateSize in plateType.sizes) {
//                if (plateSize.id == sizeId) {
//                    result = plateSize.id;
//                    break;
//                }
//            }
//        }
//    }
//    return result;
//}

- (void)getALaCarteMenu:(void (^)(PLMenu *, NSError *))block
{
    if (aLaCarteMenu) {
        block(aLaCarteMenu, nil);
    } else {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"api/menus/a-la-carte"];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        PLMenu *menuRootObject = [[PLMenu alloc]init];
        [menuRootObject setMenuType:MenuTypeALaCarte];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        [connect setJsonRootObject:menuRootObject];

        [connect setCompletionBlock:^(PLMenu *menuConnectResult, NSError *err) {
            if (!err) {
                aLaCarteMenu = menuConnectResult;
                block(menuConnectResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
    }
}

- (void)getAddOnMenu:(void (^)(PLMenu *, NSError *))block
{
    if (addOnsMenu) {
        block(addOnsMenu, nil);
    } else {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"api/menus/add-ons"];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        PLMenu *menuRootObject = [[PLMenu alloc]init];
        [menuRootObject setMenuType:MenuTypeAddOn];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        [connect setJsonRootObject:menuRootObject];
        
        [connect setCompletionBlock:^(PLMenu *menuConnectResult, NSError *err) {
            if (!err) {
                addOnsMenu = menuConnectResult;
                block(menuConnectResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
    }
}

- (void)getPlateMenu:(PLPlateSize *)plateSize plateType:(PLPlateTypeSize *)plateTypeSize forBlock:(void (^)(PLMenu *menuResult, NSError *))block
{
    BOOL exists = false;
    if ([plateMenus count] >0) {
        for (PLMenu *menu in plateMenus) {
            if (([menu plateSize] == plateSize) && ([menu plateTypeSize] == plateTypeSize)) {
                block(menu, nil);
                exists = true;
                break;
            }
        }
    }
    
    if (!exists) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@", BASEURL, @"api/modifiers/", [plateSize id]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        PLMenu *menuRootObject = [[PLMenu alloc]init];
        [menuRootObject setMenuType:MenuTypePlate];
        [menuRootObject setPlateTypeSize:plateTypeSize];
        [menuRootObject setPlateSize:plateSize];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        [connect setJsonRootObject:menuRootObject];
        
        [connect setCompletionBlock:^(PLMenu *menuConnectResult, NSError *err) {
            if (!err) {
                [menuConnectResult setPlateSize:plateSize];
                [menuConnectResult setPlateTypeSize:plateTypeSize];
                [plateMenus addObject:menuConnectResult];
                block(menuConnectResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
    }
}

//- (void) getMenu:(void (^)(PLMenu *menuResult, NSError *err))block
//{
//    if (menu) {
//        block(menu, nil);
//    } else {

//        NSURL *url = [NSURL URLWithString:@"http://ep2.gulosolutions.com/menus/get_modifiers/1"];
//        NSURLRequest *req = [NSURLRequest requestWithURL:url];
//        
//        PLMenu *menuRootObject = [[PLMenu alloc]init];
//        PLConnection *connect = [[PLConnection alloc]initWithRequest:req];
//        [connect setJsonRootObject:menuRootObject];
//        
//        [connect setCompletionBlock:^(PLMenu *menuConnectResult, NSError *err) {
//            if (!err) {
//                menu = menuConnectResult;
//                block(menuConnectResult, nil);
//            } else {
//                block(nil, err);
//            }
//        }];
//        [connect start];
//        menu = [self buildFakeMenu];
//        block(menu, nil);
//    }
//}
//
//- (PLMenu *)buildFakeMenu
//{
//    PLMenu *fakeMenu = [[PLMenu alloc]init];
//    
//    NSMutableArray *mainItems = [[NSMutableArray alloc] init];
//    NSMutableArray *sideItems = [[NSMutableArray alloc] init];
//    
//    [mainItems addObject:[[PLMenuItem alloc] initWithName:@"Beef Stroganoff" itemType:MenuItemMain itemId:@"31"]];
//    [mainItems addObject:[[PLMenuItem alloc] initWithName:@"Wild Salmon" itemType:MenuItemMain itemId:@"32"]];
//    [mainItems addObject:[[PLMenuItem alloc] initWithName:@"Moo Goo Gai Pan" itemType:MenuItemMain itemId:@"33"]];
//    [mainItems addObject:[[PLMenuItem alloc] initWithName:@"Braised Pork Loin" itemType:MenuItemMain itemId:@"34"]];
//    [mainItems addObject:[[PLMenuItem alloc] initWithName:@"Tofu Enchiladas" itemType:MenuItemMain itemId:@"35"]];
//    
//    for (PLMenuItem *item in mainItems) {
//        item.price = 10.0;
//    }
//    
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Miso Eggplant" itemType:MenuItemSide itemId:@"4"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Zucchini" itemType:MenuItemSide itemId:@"5"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Broccoli" itemType:MenuItemSide itemId:@"6"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Animal Crackers" itemType:MenuItemSide itemId:@"7"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Fudge Ice Cream" itemType:MenuItemSide itemId:@"8"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Spinach" itemType:MenuItemSide itemId:@"9"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Artichokes" itemType:MenuItemSide itemId:@"10"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Sardines" itemType:MenuItemSide itemId:@"11"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Macaroni and Cheese" itemType:MenuItemSide itemId:@"12"]];
//    [sideItems addObject:[[PLMenuItem alloc] initWithName:@"Moroccan Cauliflower" itemType:MenuItemSide itemId:@"13"]];
//
//    for (PLMenuItem *item in sideItems) {
//        item.price = 4.0;
//    }
//    
//    [fakeMenu setMains:mainItems];
//    [fakeMenu setSides:sideItems];
//    return fakeMenu;
//}

- (void) getPlateSizesAndTypes:(void (^)(PLPlatesTypesAndSizes *, NSError *))block
{
    if (plateTypesSizes) {
        block(plateTypesSizes, nil);
    } else {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"api/plates"];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        PLPlatesTypesAndSizes *plates = [[PLPlatesTypesAndSizes alloc]init];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        [connect setJsonRootObject:plates];
        
        [connect setCompletionBlock:^(PLPlatesTypesAndSizes *platesResult, NSError *err) {
            if (!err) {
                plateTypesSizes = platesResult;
                block(platesResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
        
        
        // Make a request
        
        // For now hard code 2 Plate Types
        
        // 1 Main and 2 Sides
//        PLPlateType *plateType1Main2Sides = [[PLPlateType alloc]init];
//        [plateType1Main2Sides setName:@"1 Main 2 Sides"];
//        [plateType1Main2Sides setId:1];
//        [plateType1Main2Sides setSizes:[[NSMutableArray alloc]init]];
//        
//        PLPlateSize *plateType1SizeFit = [[PLPlateSize alloc]init];
//        [plateType1SizeFit setName:@"Fit"];
//        [plateType1SizeFit setPrice:10.00];
//        [plateType1SizeFit setId:90];
//        
//        PLPlateSize *plateType1SizeUltra = [[PLPlateSize alloc]init];
//        [plateType1SizeUltra setName:@"Ultra"];
//        [plateType1SizeUltra setPrice:12.00];
//        [plateType1SizeUltra setId:91];
//        
//        PLPlateSize *plateType1SizeKids = [[PLPlateSize alloc]init];
//        [plateType1SizeKids setName:@"Kids"];
//        [plateType1SizeKids setPrice:8.00];
//        [plateType1SizeKids setId:92];
//        
//        [[plateType1Main2Sides sizes] addObject:plateType1SizeFit];
//        [[plateType1Main2Sides sizes] addObject:plateType1SizeUltra];
//        [[plateType1Main2Sides sizes] addObject:plateType1SizeKids];
//        
//        [plates addObject:plateType1Main2Sides];
//        
//        // 4 Sides
//        PLPlateType *plateType4Sides = [[PLPlateType alloc]init];
//        [plateType4Sides setName:@"4 Sides"];
//        [plateType4Sides setId:2];
//        [plateType4Sides setSizes:[[NSMutableArray alloc]init]];
//        
//        PLPlateSize *plateType2SizeFit = [[PLPlateSize alloc]init];
//        [plateType2SizeFit setName:@"Fit"];
//        [plateType2SizeFit setPrice:10.00];
//        [plateType2SizeFit setId:80];
//        
//        PLPlateSize *plateType2SizeUltra = [[PLPlateSize alloc]init];
//        [plateType2SizeUltra setName:@"Ultra"];
//        [plateType2SizeUltra setPrice:12.00];
//        [plateType2SizeUltra setId:81];
//        
//        PLPlateSize *plateType2SizeKids = [[PLPlateSize alloc]init];
//        [plateType2SizeKids setName:@"Kids"];
//        [plateType2SizeKids setPrice:8.00];
//        [plateType2SizeKids setId:82];
//        
//        [[plateType4Sides sizes] addObject:plateType2SizeFit];
//        [[plateType4Sides sizes] addObject:plateType2SizeUltra];
//        [[plateType4Sides sizes] addObject:plateType2SizeKids];
//        
//        [plates addObject:plateType4Sides];
        
    }
}

- (void)clearCache
{
    plateTypesSizes = nil;
    plateMenus = nil;
    aLaCarteMenu = nil;
    addOnsMenu = nil;
}

+ (PLPlateStore *)sharedStore
{
    static PLPlateStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
        [sharedStore clearCache];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

@end