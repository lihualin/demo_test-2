//
//  paySubInfoRespBean.h
//  Model_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "BaseBean.h"

@interface paySubInfoRespBean : BaseBean

@property (nonatomic) NSArray *charge_detail;
@property (nonatomic) NSString *charge_month;
@property (nonatomic) NSString *charge_year;
@property (nonatomic) NSString *order_id;
@property (nonatomic) NSString *room;

+(paySubInfoRespBean *)sharedInstance;
-(NSMutableArray *)create:(NSString *)str;

-(void)setCharge_detail:(NSArray *)myCharge_detail;
-(void)setCharge_month:(NSString *)myCharge_month;
-(void)setCharge_year:(NSString *)myCharge_year;
-(void)setOrder_id:(NSString *)myOrder_id;
-(void)setRoom:(NSString *)myRoom;

-(NSArray *)getCharge_detail;
-(NSString *)getCharge_month;
-(NSString *)getCharge_year;
-(NSString *)getOreder_id;
-(NSString *)getRoom;
@end
