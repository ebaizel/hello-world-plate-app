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
#import "PLAccount.h"
#import "PLPayment.h"
#import "PLOrder.h"

#ifdef DEBUG
    #define BASEURL @"https://platesf.com/"
#else
    #define BASEURL @"https://platesf.com/"
#endif

@implementation PLPlateStore

// PAYMENTS

- (void)addPayment:(PLPayment *)pPayment forBlock:(void (^)(PLPayment *, NSError *))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"me/payments"];
    urlString = [self addAccessToken:urlString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"cardNumber=%@&expiryMonth=%@&expiryYear=%@&cvv=%@", pPayment.cardNumber,
                            pPayment.expiryMonth, pPayment.expiryYear, pPayment.cvv];
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    PLPayment *paymentRootObject = [[PLPayment alloc]init];
    PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
    [connect setJsonRootObject:paymentRootObject];
    
    [connect setCompletionBlock:^(PLPayment *addPaymentResult, NSError *err) {
        if (!err) {
            payment = addPaymentResult;
            block(addPaymentResult, nil);
        } else {
            block(nil, err);
        }
    }];
    [connect start];
}

// ARCHIVING HELPER

- (void)archiveThis:(NSObject *)thing
{
    NSString *path = [self accountArchivePath];
    [NSKeyedArchiver archiveRootObject:thing toFile:path];
}


// ACCOUNT

- (PLAccount *) getAccount
{
    return account;
}

- (void)getOrderHistory:(void (^)(NSMutableArray *, NSError *))block;
{
//    if (LOCAL) {
        NSMutableArray *orders = [[NSMutableArray alloc]init];
        PLOrder *order1 = [[PLOrder alloc]init];
        [order1 setPickupDate:[[NSDate alloc]init]];
        [order1 setPickupOption:@"Curbside"];
        order1.cost=10.04;
        [orders addObject:order1];

        PLOrder *order2 = [[PLOrder alloc]init];
        [order2 setPickupDate:[[NSDate alloc]init]];
        [order2 setPickupOption:@"In store"];
        order2.cost=19.97;
        [orders addObject:order2];

        block (orders, nil);
        
//    }
}

- (void)getPayment:(void (^)(PLPayment *, NSError *))block;
{
//    if (LOCAL) {
    PLPayment *result = [[PLPayment alloc]init];
    [result setCardType:@"Visa"];
    [result setExpiryMonth:@"2"];
    [result setExpiryYear:@"2015"];
    [result setLastFourDigits:@"3698"];
    block (result, nil);
//    }
}

- (void)login:(PLAccount *)pAccount forBlock:(void (^)(PLAccount *, NSError *))block
{
    if (LOCAL) {
        
        PLAccount *accountResult = [[PLAccount alloc]init];
        [accountResult setLogin:@"pierre23@gmail.com"];
        [accountResult setPassword:@"123123"];
        [accountResult setAccessToken:@"abcdef123456"];
        block(accountResult, nil);
        
        NSString *path = [self accountArchivePath];
        [NSKeyedArchiver archiveRootObject:accountResult toFile:path];
        
        account = accountResult;
        block(accountResult, nil);        
    } else {
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"login"];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@", pAccount.login, pAccount.password];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        PLAccount *accountRootObject = [[PLAccount alloc]init];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        [connect setJsonRootObject:accountRootObject];
        
        [connect setCompletionBlock:^(PLAccount *loginResult, NSError *err) {
            if (!err) {
                account = loginResult;
                block(loginResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
    }
}

- (void)createAccount:(PLAccount *)pAccount forBlock:(void (^)(PLAccount *, NSError *))block
{
    if (LOCAL) {
        PLAccount *accountResult = [[PLAccount alloc]init];
        [accountResult setLogin:@"janet63@yahoo.com"];
        [accountResult setPassword:@"blue"];
        [accountResult setAccessToken:@"abcdef123456"];
        block(accountResult, nil);
        
        NSString *path = [self accountArchivePath];
        [NSKeyedArchiver archiveRootObject:accountResult toFile:path];
        
        account = accountResult;
        block(accountResult, nil);
    } else {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"account"];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@", pAccount.login, pAccount.password];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        PLAccount *accountRootObject = [[PLAccount alloc]init];
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        [connect setJsonRootObject:accountRootObject];
        
        [connect setCompletionBlock:^(PLAccount *loginResult, NSError *err) {
            if (!err) {
                account = loginResult;
                block(loginResult, nil);
            } else {
                block(nil, err);
            }
        }];
        [connect start];
    }
}

- (void)logout:(void (^)(NSError *))block
{
    if (LOCAL) {
        [self clearCache];
        block(nil);
    } else {

        NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, @"logout"];
        urlString = [self addAccessToken:urlString];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"accessToken=%@", account.accessToken];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        PLConnection *connect = [[PLConnection alloc]initWithRequest:request];
        
        [connect setCompletionBlock:^(PLAccount *accountRootObject, NSError *err) {
            if (!err) {
                [self clearCache];
                block(nil);
            } else {
                block(err);
            }
        }];
        [connect start];
    }
}

// MENUS

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
    if (LOCAL) {
        
        PLMenu *menuRootObject = [[PLMenu alloc]init];
        [menuRootObject setMenuType:MenuTypeAddOn];
        PLMenuItem *item = [[PLMenuItem alloc]init];
        [item setName:@"Frog Legs"];
        [item setPlateId:@"abc123"];
        [item setPrice:3.50];
        [item setItemDescription:@"Yummy frog legs"];
        NSMutableArray *addons = [[NSMutableArray alloc]initWithObjects:item, nil];
        [menuRootObject setAddons:addons];
        block(menuRootObject, nil);
        
    } else {
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
        NSLog(@"url is %@", urlString);
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
                NSLog(@"Menu result is %@ ", menuConnectResult);

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
        
    }
}

// HELPERS
- (NSString *)addAccessToken:(NSString *)url
{
    NSString *result = url;
    if (account) {
        result = [NSString stringWithFormat:@"%@?accessToken=%@",url,account.accessToken];
    }
    return result;
}

// INITIALIZERS AND ARCHIVING

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [self accountArchivePath];
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!account) {
            account = nil;
        }
    }
    return self;
}

- (NSString *)accountArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"account.archive"];
}

- (void)clearCache
{
    plateTypesSizes = nil;
    plateMenus = nil;
    aLaCarteMenu = nil;
    addOnsMenu = nil;
    account = nil;
    payment = nil;
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