//
//  PLConnection.h
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface PLConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection *internalConnection;
    NSMutableData *container;
    NSURLSessionDataTask *task;
}

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property (nonatomic, strong) id <JSONSerializable> jsonRootObject;

- (id)initWithRequest: (NSURLRequest *)req;
- (void) start;

@end
