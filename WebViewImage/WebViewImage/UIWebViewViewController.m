//
//  UIWebViewViewController.m
//  WebViewImage
//
//  Created by miss on 2017/7/5.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "UIWebViewViewController.h"
#import "WebImgScrollView.h"

@interface UIWebViewViewController () <UIWebViewDelegate>

@end

@implementation UIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"http://tapi.mukr.com/mapi/wphtml/index.php?ctl=app&act=news_detail&id=VGpTSDhkemFVb3Y4Y3JXTFdRR2J4UT09";

    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //js方法遍历图片添加点击事件 返回所有图片
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var srcs = [];\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    srcs[i] = objs[i].src;\
    };\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+srcs+','+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
}

 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *str = request.URL.absoluteString;
    
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        str = [str stringByReplacingOccurrencesOfString:@"myweb:imageClick:"
                                             withString:@""];
        NSArray * imageUrlArr = [str  componentsSeparatedByString:@","];
        [WebImgScrollView showImageWithImageArr:imageUrlArr];
        
    }
    
    return YES;
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
