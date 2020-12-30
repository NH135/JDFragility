//
//  UIButton+Extend.h
//  米庄理财
//
//  Created by aicai on 2016/12/3.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef NS_ENUM(NSUInteger, MZButtonType) {
    MZMainButtonType = 1,
    MZCodeButtonType,
};

@interface UIButton (Extend)

/**
 统一的按钮类型
 */
@property (nonatomic, assign) IBInspectable MZButtonType mzButtonType;

/**
 *  创建barButtonItem
 *
 *  @param imageName 按钮背景图片
 *  @param type      barButton类型：0为leftBarButton 1为rightBarButtonItem
 *  @param bounds    按钮bounds
 *  @param vc        当前viewController
 *  @param sel       按钮方法
 *
 *  @return UIButton
 */
+ (UIButton *)initBarButtonItemWithImageName:(NSString *)imageName barButtonType:(NSInteger)type bounds:(CGRect)bounds viewController:(UIViewController *)vc sel:(SEL)sel;

+ (UIButton *)initBarButtonItemWithTitle:(NSString *)title
                                     color:(UIColor *)color
                                      font:(UIFont *)font
                             barButtonType:(NSInteger)type
                                    bounds:(CGRect)bounds
                            viewController:(UIViewController *)vc
                                       sel:(SEL)sel;

+ (UIButton *)initBarButtonItemWithImageName:(NSString *)imageName bounds:(CGRect)bounds viewController:(UIViewController *)vc sel:(SEL)sel;


/**
 米庄主按钮

 @param frame frame
 @param title title
 @param target target
 @param sel action
 @return button
 */
+ (UIButton *)initYMMainButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image target:(id)target sel:(SEL)sel;
+ (UIButton *)initYMdefultButtonWithFrame:(CGRect)frame barButtonType:(NSInteger)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target sel:(SEL)sel;

- (void) addTouchUpInsideEventHandler:(void (^)(id sender))handler;

@end
