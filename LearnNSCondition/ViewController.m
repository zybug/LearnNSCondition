//
//  ViewController.m
//  LearnNSCondition
//
//  Created by zy on 16/4/11.
//  Copyright © 2016年 zybug. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSCondition *condition;

@end

@implementation ViewController

- (NSCondition *)condition {
    if (!_condition) {
        self.condition = [[NSCondition alloc] init];
    }
    return _condition;
}

- (IBAction)btnClick:(UIButton *)sender {
    [NSThread detachNewThreadSelector:@selector(createThreadOne) toTarget:self withObject:nil];
    
}

- (IBAction)btnClickTwo:(UIButton *)sender {
    [NSThread detachNewThreadSelector:@selector(createThreadTwo) toTarget:self withObject:nil];
}

- (void)createThreadOne {
    NSLog(@"--%s--\n%@",__func__, [NSThread currentThread]);
    while (1) {
        NSLog(@"等待消息");
        [self.condition lock];
        [self.condition wait];
        NSLog(@"收到");
        [self.condition unlock];
    }
}

- (void)createThreadTwo {
    NSLog(@"--%s--\n%@",__func__, [NSThread currentThread]);
    [self.condition lock];
    NSLog(@"发送");
    [self.condition signal];
    [self.condition unlock];
}

@end
