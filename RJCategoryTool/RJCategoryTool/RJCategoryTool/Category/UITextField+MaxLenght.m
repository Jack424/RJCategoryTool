//
//  UITextField+MaxLenght.m
//  BMLG
//
//  Created by JinTian on 2020/1/13.
//  Copyright © 2020 JinTian. All rights reserved.
//

#import "UITextField+MaxLenght.h"

//要关联的对象的键值，一般设置成静态的，用于获取关联对象的值
static char kMaxLengthKey;
@implementation UITextField (MaxLenght)
+ (void)load {
    //使用Xib，StoryBoard创建的UITextField
    Method  method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method  method2 = class_getInstanceMethod([self class], @selector(AdapterinitWithCoder:));
    
    //使用initWithFrame创建的UITextField
    Method method3 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method method4 = class_getInstanceMethod([self class], @selector(AdapterinitWithFrame:));
    method_exchangeImplementations(method1, method2);
    
    method_exchangeImplementations(method3, method4);

}

- (instancetype)AdapterinitWithFrame:(CGRect)frame {
    [self AdapterinitWithFrame:frame];
    if (self) {
        //注册观察UITextField输入变化的方法。
        [self addLengthObserverEvent];
    }
    return self;
}


- (instancetype)AdapterinitWithCoder:(NSCoder *)aDecoder {
    [self AdapterinitWithCoder:aDecoder];
    if (self) {
        [self addLengthObserverEvent];
    }
    return self;
}
-(void)setRj_maxLenght:(NSInteger)rj_maxLenght{
    objc_setAssociatedObject(self, &kMaxLengthKey, @(rj_maxLenght), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)rj_maxLenght{
    NSNumber * number = objc_getAssociatedObject(self, &kMaxLengthKey);
    return  [number integerValue];
}
- (void)addLengthObserverEvent {
    [self addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)valueChange {
    if (self.rj_maxLenght > 0 && self.text.length > self.rj_maxLenght) {
        self.text = [self.text substringToIndex:self.rj_maxLenght];
    }
}
@end
