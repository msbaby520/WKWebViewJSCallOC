//
//  ViewController.m
//  webkit
//
//  Created by msbaby on 2019/1/16.
//  Copyright © 2019 msbaby. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "JSOCDemoVC.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController pushViewController:[JSOCDemoVC new] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController pushViewController:[JSOCDemoVC new] animated:YES];
    
}
@end
