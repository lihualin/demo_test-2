//
//  ViewController.m
//  demo_test
//
//  Created by lihualin on 14-11-20.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import "ViewController.h"

#import "ViewController.h"
#import "CloudClient.h"
#import "ResponseViewController.h"
#import "ResponseBean.h"
#import "RequestBean.h"
#import "PayInfoReqBean.h"

@interface ViewController ()
{
    
    NSMutableArray * list;
}
@property (nonatomic ,retain) CloudClient * client;
- (IBAction)btnClick:(id)sender;
@end

@implementation ViewController
@synthesize client = _client;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _client =[CloudClient getInstance];
    _client.client.enableCache=YES;
    _client.client.userCache=NO;
     [self requestCultureListData:0];
}
//请求数据
- (void)requestCultureListData:(NSInteger)page
{
    [self showHUDWithMessage:nil view:self.view];
    
    PayInfoReqBean *infoReq = [PayInfoReqBean sharedInstance];
    
    [infoReq setAct:@"list_all_no"];
    [infoReq setCid:@"469"];
    [infoReq setPage_no:@"0"];
    
    NSDictionary *paramsDic = [RequestBean class:@"PayInfoReqBean"];
    
//    NSDictionary *paramsDic=@{@"act":@"list_all_no",@"cid":@"469",@"page_no":@"0"};
    
    [_client generalRequestMethod:@"/api_wk/property_cast_pay.php?"
                           params:nil
                        paramsDic:paramsDic
                         delegate:self
                         selector:@selector(requestPayDataSuccess:)
                    errorSelector:@selector(requestPayDataError:)];
    
}

-(void)requestPayDataSuccess:(NSDictionary *)response
{
    [self hideHUD];
   NSLog(@"response --- >%@",response);
    
    [ResponseBean class:@"PayInfoRespBean" dic:response];
    
}

//请求数据失败调用的方法
-(void)requestPayDataError:(NSDictionary *)response
{
    //    [SRMessage infoMessage:[response objectForKey:@"message"]];
    
    //时间圈停止消失
    [self hideHUD];
    //    UIView *imagenull=[super createNullView:@"您还没有相关的信息"];
    //    [self.view addSubview:imagenull];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"list"]) {
//        ResponseViewController * responseVC = segue.destinationViewController;
//        responseVC.list = list;
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showHUDWithMessage:(NSString *)message view:(UIView *)view second:(NSTimeInterval)second
{
    _HUDView = [[MBProgressHUD alloc] initWithView:view];
    _HUDView.delegate = self;
    _HUDView.labelText = message;
    _HUDView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _HUDView.mode = MBProgressHUDModeCustomView;
    
    [self.view addSubview:_HUDView];
    [_HUDView show:YES];
    [_HUDView hide:YES afterDelay:second];
}

- (void)showHUDWithMessage:(NSString *)message view:(UIView *)view
{
    _HUDView = [[MBProgressHUD alloc] initWithView:view];
    _HUDView.delegate = self;
    _HUDView.labelText = message;
    [self.view addSubview:_HUDView];
    [_HUDView show:YES];
}

- (void)hideHUD
{
    [_HUDView hide:YES];
}

#pragma mark - MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [_HUDView removeFromSuperview];
    _HUDView = nil;
}

- (IBAction)btnClick:(id)sender {
    NSLog(@"你好");
}


@end
