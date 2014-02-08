//
//  PLConnection.m
//  Plate
//
//  Created by emileleon on 12/9/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLConnection.h"
#import "PLMenuItem.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation PLConnection

@synthesize request, completionBlock, jsonRootObject;

- (id)initWithRequest: (NSURLRequest *)req
{
    self = [super init];
    if (self) {
        [self setRequest:req];
    }
    return self;
}

- (void) start
{
    container = [[NSMutableData alloc]init];
    internalConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:YES];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//    }];
//    [task resume];
    
    if (!sharedConnectionList) {
        sharedConnectionList = [[NSMutableArray alloc]init];
    }
    
    [sharedConnectionList addObject:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self jsonRootObject]) {
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil];
        [[self jsonRootObject] readFromJSONDictionary:d];
    }
    
    if ([self completionBlock]) {
        [self completionBlock]([self jsonRootObject], nil);
    }
    
    [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self completionBlock]) {
        [self completionBlock](nil, error);
    }
    [sharedConnectionList removeObject:self];
}

@end
