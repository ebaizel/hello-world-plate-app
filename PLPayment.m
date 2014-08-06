//
//  PLPayment.m
//  Plate
//
//  Created by Emile Baizel on 8/5/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLPayment.h"

@implementation PLPayment

@synthesize name;
@synthesize cardNumber;
@synthesize cardType;
@synthesize expiryMonth;
@synthesize expiryYear;
@synthesize lastFourDigits;
@synthesize paymentId;
@synthesize cvv;

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    self.name = [d objectForKey:@"name"];
    self.lastFourDigits = [d objectForKey:@"lastFourDigits"];
    self.paymentId = [d objectForKey:@"paymentId"];
    self.cardType = [d objectForKey:@"cardType"];
    self.cvv = [d objectForKey:@"cvv"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:lastFourDigits forKey:@"lastFourDigits"];
    [aCoder encodeObject:cardType forKey:@"cardType"];
    [aCoder encodeObject:paymentId forKey:@"paymentId"];
    [aCoder encodeObject:cvv forKey:@"cvv"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setLastFourDigits:[aDecoder decodeObjectForKey:@"lastFourDigits"]];
        [self setCardType:[aDecoder decodeObjectForKey:@"cardType"]];
        [self setPaymentId:[aDecoder decodeObjectForKey:@"paymentId"]];
        [self setCvv:[aDecoder decodeObjectForKey:@"cvv"]];
    }
    return self;
}

@end
