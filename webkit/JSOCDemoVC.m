//
//  ViewController.m
//  webkit
//
//  Created by msbaby on 2019/1/16.
//  Copyright © 2019 msbaby. All rights reserved.
//  JS调用OCdemo

#import "JSOCDemoVC.h"
#import <WebKit/WebKit.h>
@interface JSOCDemoVC ()<WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic,strong) WKWebView *webView;
@end

@implementation JSOCDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                          ofType:@"html"];
    
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    /*! @abstract Adds a script message handler.
     @param scriptMessageHandler The message handler to add.
     @param name The name of the message handler.
     @discussion Adding a scriptMessageHandler adds a function
     window.webkit.messageHandlers.<name>.postMessage(<messageBody>) for all
     frames.
     */
#warning msbaby - 添加脚本处理程序 注意遵循WKScriptMessageHandler协议
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"backClick"];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
#warning 注意：addScriptMessageHandler很容易引起循环引用，导致控制器无法被释放，所以必须在vc销毁前把它移除
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"backClick"];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
#warning 两个主要参数 message.name:JS那边的方法名  message.body:JS传过来的参数 为id类型 NSArray,NSDictionary,NSString等等
    
    if ([message.name isEqualToString:@"backClick"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (WKWebView *)webView{
    
    if (_webView == nil) {
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
        
        _webView.navigationDelegate = self;
        
        [self.view addSubview:_webView];
        
    }
    return _webView;
}
@end
