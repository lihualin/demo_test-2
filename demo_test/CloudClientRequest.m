//
//  CloudClientRequest.m
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "CloudClientRequest.h"

@implementation CloudClientRequest
@synthesize request = _request;
@synthesize delegate = _delegate;
@synthesize finishSelector = _finishSelector;
@synthesize finishErrorSelector = _finishErrorSelector;
@synthesize customUserInfo = _customUserInfo;
@synthesize userCache = _userCache;
@synthesize enableCache = _enableCache;
@synthesize images = _images;
-(NSString *) getRequestUrlParamStr:(NSDictionary *)params
{
    NSMutableArray * pairs=[NSMutableArray array];
    for (NSString * key in params.allKeys) {
        NSString * value = [params objectForKey:key];
        NSString * pair =[NSString stringWithFormat:@"%@=%@",key,value];
        [pairs addObject:pair];
    }
    NSString * urlParam = [pairs componentsJoinedByString:@"&"];
    return urlParam;
}

- (NSString *)getRequestUrl:(NSString *)mod
                     params:(NSDictionary *)params
{
    NSString * url = [NSString stringWithFormat:@"%@%@",@"http://dev.6cx.cc",mod];
    NSString * urlParam = [self getRequestUrlParamStr:params];
    url = [url stringByAppendingString:urlParam];
    return url;
}

//- (void) requestWithUrl:(NSString *)url userInfo:(id)userInfo
//{
//    @try {
//        self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//        
//        // delegate
//        [_request setDelegate:self];
//        
//        // userinfo
//        _request.userInfo = userInfo;
//        
//        // support GZip
//        [_request setAllowCompressedResponse:YES];
//        
//        // response encoding
//        _request.defaultResponseEncoding = NSUTF8StringEncoding;
//        
//        // start request
//        [_request startAsynchronous];
//        
//    }
//    @catch (NSException *exception) {
//        @throw exception;
//    }
//}

- (void)callMethodWithMod:(NSString *)mod
                   params:(NSDictionary *)params
               postParams:(NSDictionary *)postParams
                    files:(NSArray *)files
                  cookies:(NSDictionary *)cookies
                   header:(NSDictionary *)header
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSString * url = [self getRequestUrl:mod params:params];
    NSDictionary * muPostParam =[postParams mutableCopy];
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc]initWithObjectsAndKeys:delegate,@"delegate",NSStringFromSelector(selector),@"selector",NSStringFromSelector(errorSelector),@"errorSelector", nil];
    if (_customUserInfo && [_customUserInfo count] > 0) {
        [userInfo setObject:_customUserInfo forKey:@"customuserInfo"];
    }
    
    @try {
        ASIFormDataRequest * aRequest;
        [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:NO];
        if ([DataCheck isValidDictionary:postParams]) {
            aRequest =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
            for (NSString * key  in muPostParam) {
                NSString * value =[muPostParam objectForKey:key];
                [aRequest setPostValue:value forKey:key];
            }
        }else{
            aRequest =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        }
        [aRequest setDelegate:self];
        [aRequest setUserInfo:userInfo];
        [aRequest setAllowCompressedResponse:YES];
        aRequest.defaultResponseEncoding=NSUTF8StringEncoding;
        [aRequest setUserAgentString:@"iOS_Client"];
        [aRequest setTimeOutSeconds:60];
        [aRequest setUseCookiePersistence:NO];
        self.request=aRequest;
        [aRequest startAsynchronous];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    
}
#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    @try {
        NSString *json = [request responseString];
        NSLog(@"response -----> \n%@",json);
        
        //判断返回值里面是否包含 null 如果有 就替换为"" add by jinliang 20141002
        if([json rangeOfString:@":null"].location !=NSNotFound)
        {
            json = [json stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
            NSLog(@"yes");
        }
        else
        {
            NSLog(@"no");
        }
        //end  add
        json = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
//        // 检查结果
//        if (!TTIsStringWithAnyText(json)) {
//            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
//                                       @"1", @"code",
//                                       @"服务器返回为空内容", @"message", nil];
//            
//            [_delegate performSelector:_finishErrorSelector
//                            withObject:request.userInfo
//                            withObject:errorInfo];
//            
//            [request.downloadCache removeCachedDataForRequest:request];
//            
//            return;
//        }
        
        // 不是json
        if (![json hasPrefix:@"{"] && ![json hasPrefix:@"["]) {
            NSString *code = @"2";
            NSString *message = @"服务器返回数据格式错误";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       code, @"code",
                                       message, @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            return;
        }
        
        NSDictionary *items = [json objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:nil];;
    
        
        int code = [[items objectForKey:@"code"] intValue];
        NSString *message = [items objectForKey:@"message"];
        if (code > 0) {
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"%d", code], @"code",
                                       message, @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            return;
        }
        
        NSDictionary *result = [items objectForKey:@"data"];
        
        if ([items objectForKey:@"datalist"]!=nil) {
            result=items;
        }
        if ([items objectForKey:@"error"]!=nil) {
            result=items;
        }
        // 执行回调
        [_delegate performSelector:_finishSelector
                        withObject:request.userInfo
                        withObject:result];
    }
    @catch (NSException *exception) {
//        if (SR_DEBUG == 1) {
//            [SRMessage errorMessage:[exception reason]];
//            @throw exception;
//        } else {
//            [SRMessage errorMessage:@"程序错误，请稍后重试"];
//        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"100", @"code",
                               @"网络请求失败，请稍后重试", @"message", nil];
    
    [_delegate performSelector:_finishErrorSelector
                    withObject:request.userInfo
                     withObject:errorInfo];
}


@end
