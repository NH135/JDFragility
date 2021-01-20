//
//  UINavigationController+YMPush.m
//  YMRichCat
//
//  Created by apple on 2020/12/29.
//  Copyright © 2020 niuhui. All rights reserved.
//

#import "UINavigationController+YMPush.h"

@implementation UINavigationController (YMPush)


//路由push到下一个页面
- (void)ymPushViewControllerClassName:(NSString *)className animated:(BOOL)animated{
    Class controllClass = NSClassFromString(className);
    if (controllClass){
        UIViewController *endController = [[controllClass alloc] init];
        [self ymPushViewController:endController animated:animated];
    }
}

//push到下一个页面
- (void)ymPushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    for(UIView *temp in self.navigationBar.subviews)
    {
        [temp setExclusiveTouch:YES];
    }

    [self pushViewController:viewController animated:animated];
}

//push到下一个页面，当前页面从栈种删除
- (void)ymPushViewController:(UIViewController *)viewController removeSelf:(BOOL)remove animated:(BOOL)animated{
    if (remove) {
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
        [viewControllers removeLastObject];
        [viewControllers addObject:viewController];
        [self setViewControllers:viewControllers animated:animated];
    } else {
        [self ymPushViewController:viewController animated:animated];
    }
}
//返回到某一个页面
- (void)ymPopToViewControllerForIndex:(NSInteger)index animated:(BOOL)animated{
    NSInteger count = self.viewControllers.count-index-1;
    UIViewController *controller;
    if (count >= 0 && count < self.viewControllers.count) {
        controller = self.viewControllers[count];
    }
    if (controller) {
        [self popToViewController:controller animated:animated];
    } else {
        [self popToRootViewControllerAnimated:animated];
    }
}
@end
