//
//  UIAlertController+GRJAlert.m
//  HobayCn
//
//  Created by 易上云 on 2017/5/27.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import "UIAlertController+GRJAlert.h"
#import "UIColor+GRJColor.h"
#import "RJMainMacros.h"
#import "RJColorAndFont.h"
@implementation UIAlertController (GRJAlert)


+(void)ShowAlertWithViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle sure:(alertSureBlock)sureAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *  action) {
        !sureAction ? : sureAction();
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


+(void)ShowAlertWithViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message leftActionTitle:(NSString *)leftActionTitle  rightActionTitle:(NSString *)rightActionTitle leftAction:(leftAlertSureBlock)leftAction rightAction:(rightAlertSureBlock)rightAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:leftActionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        !leftAction ? : leftAction();
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:rightActionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        !rightAction ? : rightAction();
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


//只有一个按钮
+(void)ShowAlertOneWithViewController:(UIViewController *)viewController Title:( NSString *)title message:( NSString *)message  actionSureTitle:( NSString *)actionTitle sure:(alertSureBlock)sureAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        !sureAction ? : sureAction();
    }];
    [alertController addAction:action1];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+(void)ShowAlertTextFieldWithViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message  placeholdStr:(NSString *)placeholdStr actionTitle:(NSString *)actionTitle sure:(void(^)(NSString *text))sureAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
        sureAction([alertController.textFields firstObject].text);
    }];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeholdStr attributes:@{NSFontAttributeName:rj_kFont_26,NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]}];
    }];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end
