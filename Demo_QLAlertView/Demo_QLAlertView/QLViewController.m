//
//  QLViewController.m
//  QLDemo
//
//  Created by Shrek on 15/5/12.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifndef QLLog
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define QLLog(FORMAT, ...)
#endif
#endif

#import "QLViewController.h"
#import "QLAlertViewWithTextField.h"
#import "QLAlertViewWithImageView.h"
#import "QLAlertViewWithLabel.h"

@interface QLViewController ()

@end

@implementation QLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [bu setCenter:CGPointMake(160, 50)];
    [bu addTarget:self action:@selector(showAltertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
}

- (void)showAltertView {
    [self alertViewWithTextField];
}

- (void)alertViewWithLabel {
    QLAlertViewWithLabel *alertLabel = [[QLAlertViewWithLabel alloc] init];
    [alertLabel setStrTitle:@"提醒"];
    [alertLabel setStrContent:@"这是内容这是内容\n这是内容这是内容这\n\n是内容这是内容"];
    [alertLabel setBlkChooseButtonAction:^(UIButton *button, BOOL state){
        if (state == YES) {
            QLLog(@"%s- 确认 %@", __FUNCTION__, [button titleForState:UIControlStateNormal]);
        } else {
            QLLog(@"%s- 取消 %@", __FUNCTION__, [button titleForState:UIControlStateNormal]);
        }
    }];
    
    [self.view.window addSubview:alertLabel];
}

- (void)alertViewWithImageView {
    QLAlertViewWithImageView *alterView = [[QLAlertViewWithImageView alloc] init];
    [alterView setImgToDisplay:[UIImage imageNamed:@"0.png"]];
    [alterView setStrTitle:@"确认要删除这张图片吗?"];
    [alterView setBlkChooseButtonAction:^(UIButton *button, BOOL state){
        if (state == YES) {
            QLLog(@"%s- 确认 %@", __FUNCTION__, [button titleForState:UIControlStateNormal]);
        } else {
            QLLog(@"%s- 取消 %@", __FUNCTION__, [button titleForState:UIControlStateNormal]);
        }
    }];
    [self.view.window addSubview:alterView];
}

- (void)alertViewWithTextField {
    QLAlertViewWithTextField *alertTextField = [[QLAlertViewWithTextField alloc] init];
    [alertTextField setBlkChooseButtonClicked:^(UIButton *button, NSString *strText) {
        QLLog(@"%s- %@", __FUNCTION__, [button titleForState:UIControlStateNormal]);
    }];
    [self.view.window addSubview:alertTextField];
}

@end
