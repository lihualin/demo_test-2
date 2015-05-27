//
//  PayInfoReqBean.m
//  demo_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "PayInfoReqBean.h"

@implementation PayInfoReqBean
@synthesize act, cid, page_no;

+(PayInfoReqBean *)sharedInstance
{
    static PayInfoReqBean *sharedSingleton = nil;
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


-(void)setAct:(NSString *)myAct
{
    act = myAct;
}
-(void)setCid:(NSString *)myCid
{
    cid = myCid;
}
-(void)setPage_no:(NSString *)myPage_no
{
    page_no = myPage_no;
}

-(NSString *)getAct
{
    return act;
}
-(NSString *)getCid
{
    return cid;
}
-(NSString *)getPage_no
{
    return page_no;
}

@end
