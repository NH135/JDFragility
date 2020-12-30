//
//  UIButton+Extend.m
//  米庄理财
//
//  Created by aicai on 2016/12/3.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "UIButton+Extend.h"
 

@interface UIButton()

@end

@implementation UIButton (Extend)

static char overviewKey;
 

- (void)setMzButtonType:(MZButtonType)mzButtonType {
    objc_setAssociatedObject(self, @selector(mzButtonType), @(mzButtonType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MZButtonType)mzButtonType {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}



+ (UIButton *)initBarButtonItemWithImageName:(NSString *)imageName barButtonType:(NSInteger)type bounds:(CGRect)bounds viewController:(UIViewController *)vc sel:(SEL)sel {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = bounds;
    [customButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    if (type == 0) {
        vc.navigationItem.leftBarButtonItem = barButton;
    } else {
        vc.navigationItem.rightBarButtonItem = barButton;
    }
    return customButton;
}

+ (UIButton *)initBarButtonItemWithImageName:(NSString *)imageName bounds:(CGRect)bounds viewController:(UIViewController *)vc sel:(SEL)sel {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.bounds = bounds;
    [customButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    return customButton;
}

+ (UIButton *)initBarButtonItemWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font barButtonType:(NSInteger)type bounds:(CGRect)bounds viewController:(UIViewController *)vc sel:(SEL)sel{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.bounds = bounds;
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:color forState:UIControlStateNormal];
    customButton.titleLabel.font = font;
    [customButton sizeToFit];
    [customButton addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    if (type == 0) {
        vc.navigationItem.leftBarButtonItem = barButton;
        [customButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    } else {
        vc.navigationItem.rightBarButtonItem = barButton;
        [customButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return customButton;
}
 

- (void)addTouchUpInsideEventHandler:(void (^)(id sender))handler {
    objc_setAssociatedObject(self, &overviewKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionTouched:(id)sender {
    void (^block)(id) = objc_getAssociatedObject(self, &overviewKey);
    if (block) block(self);
}


@end
