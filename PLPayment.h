//
//  PLPayment.h
//  Plate
//
//  Created by Emile Baizel on 8/5/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface PLPayment : NSObject <NSCoding, JSONSerializable>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString *expiryMonth;
@property (nonatomic, strong) NSString *expiryYear;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *paymentId;
@property (nonatomic, strong) NSString *lastFourDigits;
@property (nonatomic, strong) NSString *cardType; //Visa, Amex
@property (nonatomic, strong) NSString *cvv;
@end
