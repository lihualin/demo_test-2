//
//  DetailInfoBean.m
//  Model_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "DetailInfoBean.h"

@implementation DetailInfoBean
@synthesize charge_name, price;

-(void)setCharge_name:(NSString *)myCharge_name
{
    charge_name = myCharge_name;
}

-(void)setPrice:(NSString *)myPrice
{
    price = myPrice;
}

-(NSString *)getCharge_name
{
    return charge_name;
}

-(NSString *)getPrice
{
    return price;
}

@end
