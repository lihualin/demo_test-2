//
//  ResponseViewController.h
//  RequestText
//
//  Created by lihualin on 14-11-19.
//  Copyright (c) 2014年 lihualin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResponseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic , retain) NSArray * list;
@property(nonatomic, retain) NSArray *details;
@end
