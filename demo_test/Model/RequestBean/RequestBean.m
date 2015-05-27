//
//  RequestBean.m
//  Model_test
//
//  Created by denglong on 14-11-19.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "RequestBean.h"
#import <objc/runtime.h>
#import "PayInfoReqBean.h"

@implementation RequestBean

+(NSDictionary *)class:(NSString *)inClass
{
    Class class = NSClassFromString(inClass);
    id myMessage = [class sharedInstance];
    
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList(class, &count);
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < count; i ++)
    {
        objc_property_t property = propertys[i];
        NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        NSLog(@"propertykey---->%@",key);
        
        NSString *b =[key substringToIndex:1].uppercaseString;
        NSString *getString =[[NSString alloc]initWithFormat:@"get%@%@",b,[key substringFromIndex:1]];

        SEL getS = NSSelectorFromString(getString);
        
        NSString *value = [myMessage performSelector:getS];
        NSLog(@"propertyValue----->%@",value);
        if (!value) {
            value = @"";
        }
        NSDictionary *dic = @{key:value};
        [infoDic addEntriesFromDictionary:dic];
    }
    return infoDic;
}

@end
