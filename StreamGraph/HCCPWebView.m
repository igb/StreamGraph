//
//  HCCPWebView.m
//  StreamGraph
//
//  Created by Ian Brown on 1/27/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPWebView.h"

@implementation HCCPWebView


- (id)init {
    
    NSLog(@"in web view init load");
    
    self = [super init];
    return self;
}

- (id)UIDelegate {
    return self;
}


-(void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
    NSLog(@"in did start load");
}

-(void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    
    NSLog(@"in finish load");
    
    
    
    
}
-(BOOL)webViewIsResizable:(WebView *)sender {
    return FALSE;
}


-(NSSize)getContentSize:(WebView*) webview {
    NSString *scrollHeight = [webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    NSLog(@"height %@",  scrollHeight);
    
    NSString *scrollWidth = [webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth;"];
    NSLog(@"width %@",  scrollWidth);
    
    return NSMakeSize([scrollHeight intValue], [scrollWidth intValue]);
}




@end
