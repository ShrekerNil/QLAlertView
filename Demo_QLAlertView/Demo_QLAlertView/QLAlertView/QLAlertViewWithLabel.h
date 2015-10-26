//
//  QLAlertViewWithLabel.h
//  Demo_QLAlterView
//
//  Created by Shrek on 15/2/6.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseButtonActionBlock)(UIButton *button, BOOL state);

@interface QLAlertViewWithLabel : UIView

@property (nonatomic, weak) UILabel *lblTitle;
@property (nonatomic, weak) UILabel *lblContent;
@property (nonatomic, copy) NSString *strTitle;
@property (nonatomic, strong) NSString *strContent;
@property (nonatomic, copy) ChooseButtonActionBlock blkChooseButtonAction;

@end
