//
//  PLAccount.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLAccount.h"

@implementation PLAccount

@synthesize login;
@synthesize password;
@synthesize accessToken;

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    self.accessToken = [d objectForKey:@"accessToken"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:login forKey:@"login"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject:accessToken forKey:@"accessToken"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setLogin:[aDecoder decodeObjectForKey:@"login"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
        [self setAccessToken:[aDecoder decodeObjectForKey:@"accessToken"]];
    }
    return self;
}

@end
