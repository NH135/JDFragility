//
//  UINavigationController+YMPush.h
//  YMRichCat
//
//  Created by apple on 2020/12/29.
//  Copyright © 2020 niuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (YMPush)
//push到下一个页面
- (void)ymPushViewController:(UIViewController *)viewController animated:(BOOL)animated;



//push到下一个页面
- (void)ymPushViewControllerClassName:(NSString *)className animated:(BOOL)animated;
//push到下一个页面，当前页面从栈种删除
- (void)ymPushViewController:(UIViewController *)viewController removeSelf:(BOOL)remove animated:(BOOL)animated;
//返回到某一个页面
- (void)ymPopToViewControllerForIndex:(NSInteger)index animated:(BOOL)animated;
 
@end

NS_ASSUME_NONNULL_END
