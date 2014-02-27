//
//  PLAccount.h
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLAccount : NSObject <NSCoding>

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;

@end
