//
//  PayInfoRespBean.h
//  Model_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 denglong. All rights reserved.
//

#import "ResponseBean.h"

@interface PayInfoRespBean : ResponseBean

@property (nonatomic) NSArray *datalist;

+(PayInfoRespBean *)sharedInstance;
+(NSMutableArray *)create:(NSString *)str;

-(void)setDatelist:(NSArray *)myDatalist;
-(NSArray *)getDatalist;

@end
