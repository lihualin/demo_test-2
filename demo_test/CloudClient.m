//
//  CloudClient.m
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "CloudClient.h"

@implementation CloudClient
+ (CloudClient *)getInstance
{
    CloudClient *client = [[CloudClient alloc] init];
    return client;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.client = [[CloudClientRequest alloc] init];
        _client.delegate = self;
        _client.finishSelector = @selector(finish:errorInfo:);
        _client.finishErrorSelector = @selector(finishError:errorInfo:);
    }
    
    return self;
}
#pragma mark - CloudClientRequestDelegate

- (void) finish:(NSDictionary *)delegateInfo errorInfo:(NSDictionary *)result
{
    id object = [delegateInfo objectForKey:@"delegate"];
    NSString *selectorName = [delegateInfo objectForKey:@"selector"];
    
    NSArray *parts = [selectorName componentsSeparatedByString:@":"];
    int count = [parts count];
    if (count == 2) {
        [object performSelector:NSSelectorFromString(selectorName) withObject:result];
    } else if (count == 3) {
        [object performSelector:NSSelectorFromString(selectorName) withObject:result withObject:self];
    } else {
        return;
    }
}

- (void) finishError:(NSDictionary *)delegateInfo errorInfo:(NSDictionary *)errorInfo
{
    id object = [delegateInfo objectForKey:@"delegate"];
    NSString *errorSelectorName = [delegateInfo objectForKey:@"errorSelector"];
    
    NSArray *parts = [errorSelectorName componentsSeparatedByString:@":"];
    int count = [parts count];
    if (count == 2) {
        [object performSelector:NSSelectorFromString(errorSelectorName) withObject:errorInfo];
    } else if (count == 3) {
        [object performSelector:NSSelectorFromString(errorSelectorName) withObject:errorInfo withObject:self];
    } else {
        return;
    }
}



- (void)generalRequestMethod:(NSString *)modStr
                      params:(NSDictionary *)params
                   paramsDic:(NSDictionary *)postParams
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector
{
    
    [_client callMethodWithMod:modStr
                        params:params
                    postParams:postParams
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
@end
