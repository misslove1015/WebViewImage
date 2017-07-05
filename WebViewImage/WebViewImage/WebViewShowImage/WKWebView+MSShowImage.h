//
//  WKWebView+MSShowImage.h
//  BiuBiu
//
//  Created by miss on 2017/6/8.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (MSShowImage)

- (NSArray *)getImageUrlByJS:(WKWebView *)wkWebView;

- (void)showBigImage:(NSURLRequest *)request;

@end
