//
//  WKWebViewViewController.m
//  WebViewImage
//
//  Created by miss on 2017/7/5.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "WKWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebView+MSShowImage.h"

@interface WKWebViewViewController () <WKNavigationDelegate>

@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString *url = @"http://tapi.mukr.com/mapi/wphtml/index.php?ctl=app&act=news_detail&id=VGpTSDhkemFVb3Y4Y3JXTFdRR2J4UT09";
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView getImageUrlByJS:webView];    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    [webView showBigImage:navigationAction.request];    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
