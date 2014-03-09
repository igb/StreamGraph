//
//  HCCPTabView.m
//  StreamGraph
//
//  Created by Ian Brown on 1/26/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPTabView.h"
#import "HCCPAppDelegate.h"

@implementation HCCPTabView

HCCPAppDelegate* delegate;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    NSLog(@"initing tab view...");
    NSLog(@"tabs: %lu", (unsigned long)[[super tabViewItems] count]);
    return self;
}

-(void) awakeFromNib {
    NSLog(@"awake!");
    delegate = [[NSApplication sharedApplication] delegate];
    [delegate setTabView:self];
    

}

- (void)selectLastTabViewItem:(id)sender {
    

    
    // draw the graph...
    [delegate createGraph:sender];
   
    NSLog(@"selecting last tab item...yes?");
    [super selectLastTabViewItem:sender];
    WebView  *webview = [WebView alloc];
    webview =  [[[[self selectedTabViewItem] view] subviews]objectAtIndex:0];
    //[[self.tabViewItems]
    //[self.window  setContentView:webview];
    
    [[[webview mainFrame] frameView] setAllowsScrolling:YES];
    //[[[webview mainFrame] frameView] setFrameSize:NSMakeSize(100, 100)];

    [[webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[delegate getCurrentGraphUrl]]];
    
    [delegate setWebView:webview];

    NSString *scrollHeight = [webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    NSLog(@"height %@",  scrollHeight);
    
    [delegate setMode:StackViewMode];
    
    
}


- (void)selectFirstTabViewItem:(id)sender {
    NSLog(@"overriding 1st tab...");
    //[delegate setMode:GraphViewMode];
    //[delegate displayControls:GraphViewMode];
    [super selectFirstTabViewItem:sender];
}



- (IBAction)goToView:(id)pId {
    NSTabViewItem *item = [super tabViewItemAtIndex:1];
    [super selectTabViewItem:item];
}


@end
