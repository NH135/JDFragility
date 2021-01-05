//
//  JSsignalert.h
//  JingShiIpad
//
//  Created by 牛辉 on 2018/4/2.
//  Copyright © 2018年 京正. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectClick)(NSString *selectValue);//数值

@interface JSsignalert : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;//string数组
@property (nonatomic, copy) SelectClick selectValue;
@property (nonatomic, strong) UILabel *titleLabel;





+ (JSsignalert *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                     selectStr:(NSString *)selectstr
                   selectValue:(SelectClick)selectValue;

@end
