//
//  WKWebView+MSShowImage.m
//  BiuBiu
//
//  Created by miss on 2017/6/8.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "WKWebView+MSShowImage.h"
#import <objc/runtime.h>
#import "WebImgScrollView.h"

@implementation WKWebView (MSShowImage)
static char imgUrlArrayKey;

- (void)setMethod:(NSArray *)imgUrlArray {
    objc_setAssociatedObject(self, &imgUrlArrayKey, imgUrlArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)getImgUrlArray {
    return objc_getAssociatedObject(self, &imgUrlArrayKey);
}

- (NSArray *)getImageUrlByJS:(WKWebView *)wkWebView {
    //js方法遍历图片添加点击事件返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgUrlStr='';\
    for(var i=0;i<objs.length;i++){\
    if(i==0){\
    if(objs[i].alt==''){\
    imgUrlStr=objs[i].src;\
    }\
    }else{\
    if(objs[i].alt==''){\
    imgUrlStr+='#'+objs[i].src;\
    }\
    }\
    objs[i].onclick=function(){\
    if(this.alt==''){\
    document.location=\"myweb:imageClick:\"+this.src;\
    }\
    };\
    };\
    return imgUrlStr;\
    };";
    
    //用js获取全部图片
    [wkWebView evaluateJavaScript:jsGetImages completionHandler:nil];
    
    NSString *js2 = @"getImages()";
    __block NSArray *array = [NSArray array];
    [wkWebView evaluateJavaScript:js2 completionHandler:^(id Result, NSError * error) {
        NSString *resurlt = [NSString stringWithFormat:@"%@",Result];
        if([resurlt hasPrefix:@"#"]){
            resurlt = [resurlt substringFromIndex:1];
        }
        array = [resurlt componentsSeparatedByString:@"#"];
        [wkWebView setMethod:array];
    }];
    
    return array;
}

- (void)showBigImage:(NSURLRequest *)request {
    NSString *str = request.URL.absoluteString;
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [str substringFromIndex:@"myweb:imageClick:".length];
        NSArray *imgUrlArr = [self getImgUrlArray];
        NSInteger index = 0;
        for (NSInteger i = 0; i < [imgUrlArr count]; i++) {
            if([imageUrl isEqualToString:imgUrlArr[i]]){
                index = i;
                break;
            }
        }

        [WebImgScrollView showImageWithImageArr:[self getImgUrlArray] index:index];
    }
}



@end
