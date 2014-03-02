//
//  HCCPAppDelegate.h
//  StreamGraph
//
//  Created by Ian Brown on 6/14/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "HCCPTableView.h"
#import "HCCPTabView.h"






@interface HCCPAppDelegate : NSObject <NSApplicationDelegate> {
    HCCPTableView* myTableView;
    HCCPTabView* myTabView;

    NSString* currentGraphId;
    NSString* currentGraphBackground;
    WebView* myWebView;

}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *display;


-(IBAction)createGraph:(id)pId;
-(IBAction)showView1:(id)sender;
-(IBAction)selectChartBackgroundColor:(id)sender;
-(IBAction)captureImage:(id)sender;

- (void)setTableView:(HCCPTableView*)tableView;
- (void)setTabView:(HCCPTabView*)tabView;
- (void)setWebView:(WebView*)webView;



-(NSString*)getCurrentGraphId;
-(NSString*)getCurrentGraphBackground;

-(NSURL*)getCurrentGraphUrl;




@property (assign) IBOutlet NSView* mainView;
@property (strong) NSViewController* currentViewController;


@end
