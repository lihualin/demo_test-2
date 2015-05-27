//
//  PayInfoRespBean.m
//  Model_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "PayInfoRespBean.h"

@implementation PayInfoRespBean
@synthesize datalist;

+(PayInfoRespBean *)sharedInstance
{
    static PayInfoRespBean *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        sharedSingleton = [[self alloc] initialize];
    });
    
    return sharedSingleton;
}

-(id)initialize
{
    if(self == [super init] )
    {
        
    }
    return self;
}

-(void)setArray:(NSArray *)myDatalist
{
    datalist = myDatalist;
}

-(NSArray *)getDatalist
{
    return datalist;
}

+(NSMutableArray *)create:(NSString *)str
{
    NSMutableArray *arrs = [NSMutableArray array];
    PayInfoRespBean *resp = [PayInfoRespBean sharedInstance];
    for (int i = 0; i < resp.datalist.count; i ++) {
        NSDictionary *inDic = resp.datalist[i];
        id myClass = [ResponseBean class:str dic:inDic];
        [arrs addObject:myClass];
    }
    return arrs;
}
@end
