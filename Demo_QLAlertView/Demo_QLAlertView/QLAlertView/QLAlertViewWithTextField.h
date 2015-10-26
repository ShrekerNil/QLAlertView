//
//  QLAlertViewWithTextField.h
//  Demo_QLAlterView
//
//  Created by simple07 on 14-8-21.
//  Copyright (c) 2014年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseButtonClickedBlock)(UIButton *button, NSString *strText);

@interface QLAlertViewWithTextField : UIView

@property (nonatomic, copy) void (^blkChooseButtonClicked)(UIButton *button, NSString *strText);

@end
