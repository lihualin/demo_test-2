//
//  CloudClientRequest.h
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"

@protocol CloudClientRequestDelegate<NSObject>
-(void)finish:(NSArray *)delegateInfo errorInfo :(NSDictionary *)result;
-(void)finishError :(NSArray *)delegateInfo errorInfo:(NSDictionary *)errorInfo;
@end

@interface CloudClientRequest : NSObject <ASIHTTPRequestDelegate>
{
    ASIHTTPRequest * _request;
    id<CloudClientRequestDelegate> delegate;
    SEL _finishSelector;
    SEL _finishErrorSelector;
//    NSArray * _images;
    NSDictionary * _customUserInfo;
}
@property (nonatomic , retain) ASIHTTPRequest * request;
@property (nonatomic , assign) id<CloudClientRequestDelegate> delegate;
@property (nonatomic) SEL finishSelector;
@property (nonatomic) SEL finishErrorSelector;
@property (nonatomic ,retain) NSArray * images;
@property (nonatomic ,retain) NSDictionary * customUserInfo;
@property (nonatomic) BOOL userCache;
@property (nonatomic) BOOL enableCache;
- (NSString *)getRequestUrl:(NSString *)mod
                     params:(NSDictionary *)params;
- (void)callMethodWithMod:(NSString *)mod
                   params:(NSDictionary *)params
               postParams:(NSDictionary *)postParams
                    files:(NSArray *)files
                  cookies:(NSDictionary *)cookies
                   header:(NSDictionary *)header
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;


@end


