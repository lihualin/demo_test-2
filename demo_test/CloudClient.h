//
//  CloudClient.h
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudClientRequest.h"
@interface CloudClient : NSObject <CloudClientRequestDelegate>
@property (nonatomic, retain) CloudClientRequest *client;
@property (nonatomic, retain) NSDictionary *userInfo;
+ (CloudClient *)getInstance;

- (void)generalRequestMethod:(NSString *)modStr
                      params:(NSDictionary *)params
                   paramsDic:(NSDictionary *)postParams
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;
@end
