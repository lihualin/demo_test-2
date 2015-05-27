//
//  ResponseViewController.m
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "ResponseViewController.h"
#import "CustomCell.h"
#import "PayInfoRespBean.h"
#import "paySubInfoRespBean.h"

@implementation ResponseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.list = [PayInfoRespBean create:@"paySubInfoRespBean"];
    paySubInfoRespBean *paySub = _list[0];
    self.details = [paySub create:@"DetailInfoBean"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _list.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CELL";
    //自定义cell类
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        NSArray * views = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell=[views objectAtIndex:0];
    }
    cell.info = _list[indexPath.section];
    cell.details = _details[indexPath.section];
    [cell setData];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
@end
