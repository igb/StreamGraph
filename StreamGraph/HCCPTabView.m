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
    NSLog(@"awake in tab view!");
    NSLog(@"delegate is %@", delegate);
    delegate = [[NSApplication sharedApplication] delegate];
    [delegate setTabView:self];
    

}

- (void)selectLastTabViewItem:(id)sender {
    

    
    // draw the graph...
    if (sender != nil && [sender class] == [NSButton class]) {
        [delegate createGraph:sender];
        [delegate setMode:[delegate getGraphMode:[sender tag]]];
        [delegate displayControls:[delegate getGraphMode:[sender tag]]];

    } else {
        [delegate createGraph:nil];
    }
    
   
    NSLog(@"selecting last tab item...yes?");
    [super selectLastTabViewItem:sender];
    WebView  *webview = [WebView alloc];
    webview =  [[[[self selectedTabViewItem] view] subviews]objectAtIndex:0];
    [[[webview mainFrame] frameView] setAllowsScrolling:YES];
   
    [[webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[delegate getCurrentGraphUrl]]];
    
    [delegate setWebView:webview];

    NSString *scrollHeight = [webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    NSLog(@"height %@",  scrollHeight);
    
    
    
}


-(IBAction)dataPanelActivated:(id)sender {
    
}

- (void)showTableData:(id)sender {
    NSLog(@"overriding xxst2 tab...%@",[[delegate tableTabView] identifier]);
    NSLog(@"overriding xxst2 tab...%@",[[delegate graphTabView] identifier]);

    [delegate setMode:GraphViewMode];
    [delegate displayControls:GraphViewMode];
    [[delegate mainTabView] selectTabViewItemWithIdentifier:[[delegate tableTabView] identifier]];
}

- (void)showChart:(id)sender {
    [delegate setMode:BarViewMode];
    [delegate displayControls:BarViewMode];
    [[delegate mainTabView] selectTabViewItemWithIdentifier:[[delegate graphTabView] identifier]];

}






@end
