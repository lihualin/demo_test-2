//
//  PayInfoReqBean.h
//  demo_test
//
//  Created by denglong on 14-11-20.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "RequestBean.h"

@interface PayInfoReqBean : RequestBean
@property (nonatomic) NSString *act;
@property (nonatomic) NSString *cid;
@property (nonatomic) NSString *page_no;

+(PayInfoReqBean *)sharedInstance;

-(void)setAct:(NSString *)myAct;
-(void)setCid:(NSString *)myCid;
-(void)setPage_no:(NSString *)myPage_no;

-(NSString *)getAct;
-(NSString *)getCid;
-(NSString *)getPage_no;

@end
