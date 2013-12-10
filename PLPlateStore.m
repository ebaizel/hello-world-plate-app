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

@implementation PLPlateStore

- (void) getMenu:(void (^)(PLMenu *menuResult, NSError *err))block
{
    if (menu) {
        block(menu, nil);
    } else {
        
        NSURL *url = [NSURL URLWithString:@"http://ep2.gulosolutions.com/menus/get_modifiers/1"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        PLMenu *menuRootObject = [[PLMenu alloc]init];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:req];
        [connect setJsonRootObject:menuRootObject];
        
        [connect setCompletionBlock:^(PLMenu *menuConnectResult, NSError *err) {
            if (!err) {
                menu = menuConnectResult;
                block(menuConnectResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
    }
}

- (void)clearCache
{
    menu = nil;
}

+ (PLPlateStore *)sharedStore
{
    static PLPlateStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

@end