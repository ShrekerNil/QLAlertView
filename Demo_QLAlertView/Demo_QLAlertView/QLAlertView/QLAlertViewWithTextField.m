//
//  QLAlertViewWithTextField.m
//  Demo_QLAlterView
//
//  Created by simple07 on 14-8-21.
//  Copyright (c) 2014年 Personal. All rights reserved.
//

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define QLLog(FORMAT, ...)
#endif

#import "QLAlertViewWithTextField.h"

#define kSpace 10
#define kStrTip @"顺便写点什么吧！"
#define kLineWidth 0.5f
#define kColorButtonText [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]

@interface QLAlertViewWithTextField () <UITextViewDelegate>
{
    UIView *_viewAltertBody;
    CGRect _rectViewAltertBodyOrigin;
    UITextView *_textView;
    UILabel *_lblPlaceholder;
}

@end

@implementation QLAlertViewWithTextField

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
        [self loadObserver];
    }
    return self;
}

#pragma mark - Load default UI and Data
- (void)loadDefaultSetting {
    [self setFrame:[UIScreen mainScreen].bounds];
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]];
    // 添加alterView
    _viewAltertBody = [[UIView alloc] init];
    CGFloat fAlertBodyWidth = 250;
    CGFloat fAlertBodyHeight = 150;
    [_viewAltertBody setFrame:CGRectMake((self.frame.size.width-fAlertBodyWidth)/2, 150, fAlertBodyWidth, fAlertBodyHeight)];
    [_viewAltertBody setBackgroundColor:[UIColor whiteColor]];
    [_viewAltertBody.layer setCornerRadius:3.0f];
    [_viewAltertBody setAlpha:0.2f];
    [self addSubview:_viewAltertBody];
    
    // 添加输入框
    CGRect rectViewAltertBody = _viewAltertBody.frame;
    _rectViewAltertBodyOrigin = rectViewAltertBody;
    CGFloat fTVX = 6;
    CGFloat fTVY = 6;
    CGRect rectTextView = CGRectMake(fTVX, fTVY, CGRectGetWidth(rectViewAltertBody)-2*fTVX, CGRectGetHeight(rectViewAltertBody)-8*fTVY);
    _textView = [[UITextView alloc] initWithFrame:rectTextView];
    [_textView.layer setCornerRadius:3.0f];
    [_textView.layer setBorderWidth:kLineWidth];
    [_textView setDelegate:self];
    [_textView.layer setBorderColor:[UIColor grayColor].CGColor];
    [_viewAltertBody addSubview:_textView];
    [_textView becomeFirstResponder];
    
    // 自定义placeholder
    _lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMinY(rectTextView)-6, 300, 30)];
    _lblPlaceholder.text = kStrTip;
    [_lblPlaceholder setFont:[UIFont systemFontOfSize:13]];
    [_lblPlaceholder setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [_lblPlaceholder setBackgroundColor:[UIColor clearColor]];
    [_textView addSubview:_lblPlaceholder];
    
    // 添加取消按钮
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat fBtnCancelWidth = CGRectGetWidth(rectViewAltertBody)/2;
    CGFloat fBtnCancelHeight = CGRectGetHeight(rectViewAltertBody)-CGRectGetMaxY(rectTextView);
    CGRect rectBtnCancel = CGRectMake(0, CGRectGetMaxY(rectTextView)+1, fBtnCancelWidth, fBtnCancelHeight);
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
    [viewSeperator setBackgroundColor:[UIColor grayColor]];
    [_viewAltertBody addSubview:viewSeperator];
    
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

- (void)loadObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)cancel:(UIButton *)button {
    QLLog(@"cancel");
    [self endEditing:YES];
    if (_blkChooseButtonClicked)
    {
        _blkChooseButtonClicked(button, _textView.text);
    }
    [self dismissALterView];
}
- (void)confirm:(UIButton *)button {
    QLLog(@"confirm");
    [self endEditing:YES];
    if (_blkChooseButtonClicked)
    {
        _blkChooseButtonClicked(button, _textView.text);
    }
    [self dismissALterView];
}

#pragma mark - 退出自定义AlertView
- (void)dismissALterView {
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self setAlpha:0.01f];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 通知处理事件
- (void)keyboardWillShow:(NSNotification *)notifcation {
    if (self.hidden == YES) return;
    
    CGRect rectKBStoped = [[notifcation.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [notifcation.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect rectViewAltertBody = _viewAltertBody.frame;
    CGFloat fViewAltertBodyMaxY = CGRectGetMaxY(rectViewAltertBody);
    
    if (fViewAltertBodyMaxY > rectKBStoped.origin.y) {
        CGFloat fKBStopY = rectKBStoped.origin.y;
        rectViewAltertBody.origin.y = fKBStopY - kSpace - rectViewAltertBody.size.height;
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_viewAltertBody setFrame:rectViewAltertBody];
        } completion:nil];
    }
    [UIView animateWithDuration:duration animations:^{
        [_viewAltertBody setAlpha:1.0f];
    }];
}
- (void)keyboardWillHide:(NSNotification *)notifcation {
    if (self.hidden == YES) return;
    
    double duration = [notifcation.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_viewAltertBody setFrame:_rectViewAltertBodyOrigin];
    } completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - UITextViewDelegate Methods
- (void)textViewDidChange:(UITextView *)textView {
    if (_textView.text.length == 0) {
        _lblPlaceholder.text = kStrTip;
    } else {
        _lblPlaceholder.text = @"";
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
