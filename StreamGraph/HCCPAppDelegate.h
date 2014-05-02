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
    BarViewMode,
    HeatMapMode
};



@interface HCCPAppDelegate : NSObject <NSApplicationDelegate> {
    HCCPTableView* myTableView;
    HCCPTabView* myTabView;

    NSString* currentGraphId;
    NSString* currentGraphBackground;
    NSString* currentGridColor;
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
    BOOL drawGrid;
    int gridXStepValue;
    int gridyStepValue;
    BOOL isGridEditMode;
    BOOL isShowHeatMapLegend;

    
    NSString* currentGraphType;

}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *display;
@property (assign) IBOutlet NSTabView *chartAndTableTabView;

//buttons
@property (assign) IBOutlet NSButton *barChart;
@property (assign) IBOutlet NSButton *expandStreamChart;
@property (assign) IBOutlet NSButton *zeroStreamChart;
@property (assign) IBOutlet NSButton *wiggleStreamChart;
@property (assign) IBOutlet NSButton *silStreamChart;
@property (assign) IBOutlet NSButton *gridHeatMapChart;



//

@property (assign) IBOutlet NSControl *barSpaceControlLabel;
@property (assign) IBOutlet NSSlider *barSpaceControlSlider;

@property (assign) IBOutlet NSStepper *gridXStepper;
@property (assign) IBOutlet NSStepper *gridYStepper;
@property (assign) IBOutlet NSTextField *gridXText;
@property (assign) IBOutlet NSTextField *gridYText;
@property (assign) IBOutlet NSTextField *gridXlabel;
@property (assign) IBOutlet NSTextField *gridYlabel;

@property (assign) IBOutlet NSTextField *gridlabel;
@property (assign) IBOutlet NSButton *gridCheck;
@property (assign) IBOutlet NSColorWell *gridColorChooser;
@property (assign) IBOutlet NSTextField *gridColorLabel;

@property (assign) IBOutlet NSTextField *heatMapLegendlabel;
@property (assign) IBOutlet NSButton *heatMapLegendCheck;


//
@property (assign) IBOutlet NSTabView* mainTabView;
@property (assign) IBOutlet NSTabViewItem* tableTabView;
@property (assign) IBOutlet NSTabViewItem* graphTabView;




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

-(IBAction)gridTickStepperXYAction:(id)pId;
-(IBAction)gridTickerCheck:(id)pId;


-(IBAction)heatMapLegendCheck:(id)pId;



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
- (NSTabView*) getTabView;


- (NSString *)getGraphType:(int)graphTypeId;
- (ModeType)getGraphMode:(int)graphTypeId;


- (NSString *)getCurrentGraphType;
- (void)setCurrentGraphType:(NSString*)curGraphType;


- (void)setMode:(ModeType)mode;
- (ModeType)getMode;

-(NSString*)getCurrentGraphId;
-(NSString*)getCurrentGraphBackground;
-(NSString*)getCurrentGridColor;

-(NSURL*)getCurrentGraphUrl;

-(BOOL)getDrawGrid;

- (void)setGridEditMode:(BOOL)isGridEdit;
- (BOOL)getGridEditMode;
- (BOOL)getIsShowHeatMapLegend;


@property (assign) IBOutlet NSView* mainView;
@property (strong) NSViewController* currentViewController;


@end
