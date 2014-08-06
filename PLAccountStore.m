//
//  PLAccountStore.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLAccountStore.h"
#import "PLAccount.h"

@implementation PLAccountStore

- (BOOL)login:(PLAccount *)pAccount
{
//    NSString *path = [self accountArchivePath];
//    [NSKeyedArchiver archiveRootObject:pAccount toFile:path];
//    account = pAccount;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedIn" object:self];
    return true;
}

- (PLAccount *)getAccount
{
    return account;
}

- (id)init {
    self = [super init];
//    if (self) {
//        NSString *path = [self accountArchivePath];
//        account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        if (!account) {
//            account = nil;
//        }
//    }
    return self;
}

#pragma Singleton setup

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+ (PLAccountStore *)sharedStore
{
    static PLAccountStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

- (NSString *)accountArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"account.archive"];
}

- (BOOL)logout
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:[self accountArchivePath] error:&error];
    if (success) {
//        UIAlertView *removeSuccessFullAlert=[[UIAlertView alloc]initWithTitle:@"Logged Out" message:@"Successfully logged out" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [removeSuccessFullAlert show];
        account = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedOut" object:self];        
    }
    else
    {
        NSLog(@"Could not logout; can't delete file -:%@ ",[error localizedDescription]);
    }
    return success;
}

@end
