//
//  QLAlertViewWithImageView.m
//  Demo_QLAlterView
//
//  Created by simple07 on 14/10/22.
//  Copyright (c) 2014年 Personal. All rights reserved.
//

#import "QLAlertViewWithImageView.h"

#define kSpace 10
#define kLineWidth 0.5f
#define kColorButtonText [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]

@interface QLAlertViewWithImageView () <UITextViewDelegate>
{
    UIView *_viewAltertBody;
    UILabel *_lblTitle;
    CGRect _rectViewAltertBodyOrigin;
    UIImageView *_imageView;
    UILabel *_lblPlaceholder;
}

@end

@implementation QLAlertViewWithImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    [self setFrame:[UIScreen mainScreen].bounds];
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]];
    // 添加alterView
    _viewAltertBody = [[UIView alloc] init];
    CGFloat fAlertBodyWidth = 250;
    CGFloat fAlertBodyHeight = 180;
    CGRect rectAlertBody = CGRectMake((self.frame.size.width-fAlertBodyWidth)/2, 150, fAlertBodyWidth, fAlertBodyHeight);
    _rectViewAltertBodyOrigin = rectAlertBody;
    [_viewAltertBody setFrame:rectAlertBody];
    [_viewAltertBody setBackgroundColor:[UIColor whiteColor]];
    [_viewAltertBody.layer setCornerRadius:3.0f];
    //[_viewAltertBody setAlpha:0.7f];
    [self addSubview:_viewAltertBody];
    
    // 添加一个显示文本的label
    CGRect rectLblText = CGRectMake(0, 6, CGRectGetWidth(rectAlertBody), 20);
    _lblTitle = [[UILabel alloc] initWithFrame:rectLblText];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.textColor = kColorButtonText;
    _lblTitle.backgroundColor = [UIColor clearColor];
    [_viewAltertBody addSubview:_lblTitle];
    
    // 添加ImageView
    CGFloat fImageViewX = 6;
    CGFloat fImageViewY = CGRectGetMaxY(rectLblText)+10;
    CGRect rectImageView = CGRectMake(fImageViewX, fImageViewY, CGRectGetWidth(rectAlertBody)-2*fImageViewX, CGRectGetHeight(rectAlertBody)-85);
    _imageView = [[UIImageView alloc] initWithFrame:rectImageView];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_viewAltertBody addSubview:_imageView];
    [_imageView becomeFirstResponder];
    
    // 添加取消按钮
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat fBtnCancelWidth = CGRectGetWidth(rectAlertBody)/2;
    CGFloat fBtnCancelHeight = 40;
    CGRect rectBtnCancel = CGRectMake(0, CGRectGetHeight(rectAlertBody)-fBtnCancelHeight, fBtnCancelWidth, fBtnCancelHeight);
    [btnCancel setFrame:rectBtnCancel];
    [btnCancel setTitle:@"取  消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:kColorButtonText forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTag:100];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_viewAltertBody addSubview:btnCancel];
    
    //添加分割线
    CGRect rectViewSeperator = CGRectMake(CGRectGetMaxX(rectBtnCancel), CGRectGetMinY(rectBtnCancel)-1.6, kLineWidth, CGRectGetHeight(rectBtnCancel)+1);
    UIView *viewSeperator = [[UIView alloc] initWithFrame:rectViewSeperator];
    [viewSeperator setBackgroundColor:[UIColor lightGrayColor]];
    [_viewAltertBody addSubview:viewSeperator];
    
    CGRect rectViewLine = CGRectMake(0, CGRectGetMinY(rectBtnCancel)-2, CGRectGetWidth(rectAlertBody), kLineWidth);
    UIView *viewSeperatorLine = [[UIView alloc] initWithFrame:rectViewLine];
    [viewSeperatorLine setBackgroundColor:[UIColor lightGrayColor]];
    [_viewAltertBody addSubview:viewSeperatorLine];
    
    // 添加确定按钮
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat fBtnConfirmWidth = CGRectGetWidth(rectBtnCancel);
    CGFloat fBtnConfirmHeight = CGRectGetHeight(rectBtnCancel);
    CGRect rectBtnConfirm = CGRectMake(CGRectGetMaxX(rectViewSeperator), CGRectGetMinY(rectBtnCancel), fBtnConfirmWidth, fBtnConfirmHeight);
    [btnConfirm setFrame:rectBtnConfirm];
    [btnConfirm setTitle:@"确  定" forState:UIControlStateNormal];
    [btnConfirm setTitleColor:kColorButtonText forState:UIControlStateNormal];
    [btnConfirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [btnConfirm setTag:101];
    [btnConfirm.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [_viewAltertBody addSubview:btnConfirm];
}

- (void)cancel:(UIButton *)button
{
    NSLog(@"cancel");
    [self endEditing:YES];
    if (_blkChooseButtonAction) {
        _blkChooseButtonAction(button, NO);
    }
    [self dismissALterView];
}
- (void)confirm:(UIButton *)button
{
    NSLog(@"confirm");
    [self endEditing:YES];
    if (_blkChooseButtonAction) {
        _blkChooseButtonAction(button, YES);
    }
    [self dismissALterView];
}

#pragma mark - 退出自定义AlertView
- (void)dismissALterView
{
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self setAlpha:0.01f];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Override
- (void)setImgToDisplay:(UIImage *)imgToDisplay
{
    [_imageView setImage:imgToDisplay];
}
- (void)setStrTitle:(NSString *)strTitle
{
    _lblTitle.text = strTitle;
}

@end
