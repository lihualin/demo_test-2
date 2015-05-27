//
//  CustomCell.h
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "paySubInfoRespBean.h"

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dep;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *bill;
@property (weak, nonatomic) IBOutlet UIView *bodyView;
@property (nonatomic , retain) NSDictionary * data;
@property (nonatomic, retain) paySubInfoRespBean *info;
@property (nonatomic, retain) NSArray *details;
-(void)setData;

@end
