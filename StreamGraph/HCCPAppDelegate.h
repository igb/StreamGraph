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


typedef NS_ENUM(NSInteger, ModeType) {
    GraphViewMode,
    StackViewMode,
    BarViewMode
};



@interface HCCPAppDelegate : NSObject <NSApplicationDelegate> {
    HCCPTableView* myTableView;
    HCCPTabView* myTabView;

    NSString* currentGraphId;
    NSString* currentGraphBackground;
    NSInteger currentSelectedRow;
    NSIndexSet* currentSelectedRows;
    NSMutableArray* rowColors;
    HCCPColorStack* purpleSwatch;
    HCCPColorStack* greenSwatch;
    HCCPColorStack* goldSwatch;
    HCCPColorStack* blueSwatch;
    HCCPColorStack* redSwatch;





    WebView* myWebView;
    ModeType _mode;
    long _barGap;
    

}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *display;


-(IBAction)createGraph:(id)pId;
-(IBAction)showView1:(id)sender;
-(IBAction)selectChartBackgroundColor:(id)sender;
-(IBAction)captureImage:(id)sender;
-(IBAction)exportData:(id)sender;
-(IBAction)graphStack:(id)sender;
-(IBAction)graphBar:(id)sender;
-(IBAction)setBarGap:(id)sender;

-(IBAction)applySwatch:(id)sender;
-(IBAction)reverseColumnOrder:(id)sender;






- (void)displayControls:(ModeType)mode;
- (void)setTableView:(HCCPTableView*)tableView;
- (void)setTabView:(HCCPTabView*)tabView;
- (void)setWebView:(WebView*)webView;
- (void)setSelectedRow:(NSInteger*)selectedRow;
- (void)setSelectedRowIndexes:(NSIndexSet*)selectedRowIndexes;
- (void)setSelectedRowBackground:(NSColor*)color;
- (void)initializeRowBackgroundArray:(NSInteger*)tableSize;
- (NSColor*)getRowBackground:(NSInteger*)rowId;
- (NSArray*) getDocumentColors;
- (long) getBarGap;






- (void)setMode:(ModeType)mode;

-(NSString*)getCurrentGraphId;
-(NSString*)getCurrentGraphBackground;

-(NSURL*)getCurrentGraphUrl;




@property (assign) IBOutlet NSView* mainView;
@property (strong) NSViewController* currentViewController;


@end
