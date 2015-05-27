//
//  ResponseBean.m
//  Model_test
//
//  Created by denglong on 14-11-19.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "ResponseBean.h"
#import <objc/runtime.h>
#import "PayInfoRespBean.h"

@implementation ResponseBean

+(id) class:(NSString *)inClass dic:(NSDictionary *)dic
{
    Class superClass = NSClassFromString(@"ResponseBean");
    Class class = NSClassFromString(inClass);

    id myMessage;
    if ([class isSubclassOfClass:superClass]) {
        myMessage = [class sharedInstance];
    }
    else
    {
        myMessage = [[class alloc] init];
    }
    
    
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList(class, &count);
    for (int i=0; i<count; i++)
    {
        objc_property_t property = propertys[i];
        NSString *key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        NSLog(@"propertykey---->%@",key);
        NSString *b =[key substringToIndex:1].uppercaseString;
        
        NSString *setString =[[NSString alloc]initWithFormat:@"set%@%@:",b,[key substringFromIndex:1]];
        NSLog(@"setString---->%@",setString);
        NSString *getString =[[NSString alloc]initWithFormat:@"get%@%@",b,[key substringFromIndex:1]];
        NSLog(@"getString---->%@",getString);
        
        SEL setS=NSSelectorFromString(setString);
        SEL getS=NSSelectorFromString(getString);
        
        if ([myMessage respondsToSelector:setS])
        {
            [myMessage performSelector:setS withObject:[dic objectForKey:key]];
        }
        if ([myMessage respondsToSelector:getS])
        {
            NSLog(@"输出--------->%@",[myMessage performSelector:getS]);
        }
    }
    return myMessage;
}


@end
