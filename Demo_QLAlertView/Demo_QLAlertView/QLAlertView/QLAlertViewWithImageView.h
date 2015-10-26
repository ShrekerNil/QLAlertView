//
//  QLAlertViewWithImageView.h
//  Demo_QLAlterView
//
//  Created by simple07 on 14/10/22.
//  Copyright (c) 2014年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseButtonActionBlock)(UIButton *button, BOOL state);

@interface QLAlertViewWithImageView : UIView

@property (nonatomic, copy) NSString *strTitle;
@property (nonatomic, strong) UIImage *imgToDisplay;
@property (nonatomic, copy) ChooseButtonActionBlock blkChooseButtonAction;

@end
