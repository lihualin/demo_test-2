//
//  DetailInfoBean.h
//  Model_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "BaseBean.h"

@interface DetailInfoBean : BaseBean

@property (nonatomic) NSString *charge_name;
@property (nonatomic) NSString *price;

-(void)setCharge_name:(NSString *)myCharge_name;
-(void)setPrice:(NSString *)myPrice;

-(NSString *)getCharge_name;
-(NSString *)getPrice;

@end
