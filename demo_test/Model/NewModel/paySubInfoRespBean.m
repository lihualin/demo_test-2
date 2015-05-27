//
//  paySubInfoRespBean.m
//  Model_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "paySubInfoRespBean.h"
#import "PayInfoRespBean.h"
@implementation paySubInfoRespBean
@synthesize charge_detail, charge_month, charge_year, order_id, room;

+(paySubInfoRespBean *)sharedInstance
{
    static paySubInfoRespBean *sharedSingleton = nil;
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

-(void)setCharge_detail:(NSArray *)myCharge_detail
{
    charge_detail = myCharge_detail;
}

-(void)setCharge_month:(NSString *)myCharge_month
{
    charge_month = myCharge_month;
}

-(void)setCharge_year:(NSString *)myCharge_year
{
    charge_year = myCharge_year;
}

-(void)setOrder_id:(NSString *)myOrder_id
{
    order_id = myOrder_id;
}

-(void)setRoom:(NSString *)myRoom
{
    room = myRoom;
}

-(NSArray *)getCharge_detail
{
    return charge_detail;
}

-(NSString *)getCharge_month
{
    return charge_month;
}

-(NSString *)getCharge_year
{
    return charge_year;
}

-(NSString *)getOreder_id
{
    return order_id;
}

-(NSString *)getRoom
{
    return room;
}

-(NSMutableArray *)create:(NSString *)str
{
    NSMutableArray *arrs = [NSMutableArray array];
    NSArray *paySubs = [PayInfoRespBean create:@"paySubInfoRespBean"];
    for (paySubInfoRespBean *paySub in paySubs) {
        NSMutableArray *arrSub = [NSMutableArray array];
        for (int i = 0; i < paySub.charge_detail.count; i ++) {
            NSDictionary *inDic = paySub.charge_detail[i];
            id myClass = [ResponseBean class:str dic:inDic];
            [arrSub addObject:myClass];
        }
        [arrs addObject:arrSub];
    }
    return arrs;
}
@end
