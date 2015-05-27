//
//  ViewController.h
//  demo_test
//
//  Created by lihualin on 14-11-20.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD * _HUDView;
}
- (void)showHUDWithMessage:(NSString *)message view:(UIView *)view;
- (void)hideHUD;
- (void)showHUDWithMessage:(NSString *)message view:(UIView *)view second:(NSTimeInterval)second;

@end

