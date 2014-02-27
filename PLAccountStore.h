//
//  PLAccountStore.h
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLAccount;

@interface PLAccountStore : NSObject
{
    PLAccount *account;
}

+ (PLAccountStore *)sharedStore;
- (PLAccount *) getAccount;

- (BOOL) login:(PLAccount *)account;
- (BOOL) logout;

@end
