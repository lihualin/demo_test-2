//
//  CustomCell.m
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "CustomCell.h"
#import "DetailInfoBean.h"
@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
//    for (int i =0; i <[[self.data objectForKey:@"charge_detail"] count]; i ++) {
//        UILabel * lable =[[UILabel alloc]initWithFrame: CGRectMake(20, i*17+10, 200, 17)];
//        lable.textColor=[UIColor grayColor];
//        lable.tag =i*10;
//        lable.font=[UIFont systemFontOfSize:12];
//        [self.bodyView addSubview:lable];
//    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData
{
    self.dep.text= _info.room;

    self.time.text = [NSString stringWithFormat:@"%@年%@月", _info.charge_year, _info.charge_month];
    self.bill.text = _info.order_id;

    NSArray * Views=self.bodyView.subviews;
    for (UIView * view in Views) {
        [view removeFromSuperview];
    }
    for (int i =0; i <_info.charge_detail.count; i ++) {
        DetailInfoBean *detail = _details[i];
        
        UILabel * lable =[[UILabel alloc]initWithFrame: CGRectMake(20, i*17+10, 200, 17)];
        lable.textColor=[UIColor grayColor];
       
        lable.text= [NSString stringWithFormat:@"%@:%@",detail.charge_name, detail.price];
        lable.font=[UIFont systemFontOfSize:12];
        [self.bodyView addSubview:lable];
    }
    self.bodyView.frame= CGRectMake(0, self.bodyView.frame.origin.y, 320, _info.charge_detail.count*17+15);
    self.frame =CGRectMake(0, 0, 320, self.bodyView.frame.size.height+self.bodyView.frame.origin.y);
}
@end
