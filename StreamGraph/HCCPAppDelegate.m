//
//  HCCPAppDelegate.m
//  StreamGraph
//
//  Created by Ian Brown on 6/14/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPAppDelegate.h"
#import "HCCPColorStack.h"
#import "HCCPStreamGraphWriter.h"
#import "HCCPBarGraphWriter.h"
#import "HCCPHeatMapGraphWriter.h"



@implementation HCCPAppDelegate

- (id) init
{
    NSLog(@"my deegate has been inititalized...");
    brightness = 1.0f;
    return [super init];
}


- (void)mouseDown:(NSEvent *)theEvent
{
    NSLog(@"mouse");
}

- (void)displayControls:(ModeType)mode {
    
    NSLog(@"display control called %ld", mode);
   
    switch (mode)
    
    {
        case GraphViewMode:
            
  
            [self toggleBarControls:YES];

            
            break;
            
        case BarViewMode:
  
            [self toggleBarControls:NO];
            [self toggleStackControls:YES];
            [self toggleHeatMapControls:YES];
            [self togglePieControls:YES];
            break;
            
        case StackViewMode:
            
        
            [self toggleBarControls:YES];
            [self toggleStackControls:NO];
            [self toggleHeatMapControls:YES];
            [self togglePieControls:YES];

            
            break;
            
        case HeatMapMode:
            [self toggleBarControls:YES];
            [self toggleStackControls:YES];
            [self toggleHeatMapControls:NO];
            [self togglePieControls:YES];
            break;
            
        case PieMode:
            [self toggleBarControls:YES];
            [self toggleStackControls:YES];
            [self toggleHeatMapControls:YES];
            [self togglePieControls:NO];
            break;
            
        default:
            
            
            [self toggleBarControls:YES];
            

            
            
            break;
            
    }

    
}

-(void)toggleStackControls:(BOOL)toggle  {
    [[self gridCheck] setHidden:toggle];
    [[self gridlabel] setHidden:toggle];
    [[self gridXText] setHidden:toggle];
    [[self gridXStepper] setHidden:toggle];
    [[self gridYText] setHidden:toggle];
    [[self gridYStepper] setHidden:toggle];
    [[self gridXlabel] setHidden:toggle];
    [[self gridYlabel] setHidden:toggle];
    [[self gridColorChooser] setHidden:toggle];
    [[self gridColorLabel] setHidden:toggle];

    
}

-(void)toggleHeatMapControls:(BOOL)toggle  {
    [[self heatMapLegendlabel] setHidden:toggle];
    [[self heatMapLegendCheck] setHidden:toggle];
    [[self heatMapBucketLabel] setHidden:toggle];
    [[self heatMapBucketSlider] setHidden:toggle];
    [[self heatMapColorBrewerSelector] setHidden:toggle];
    [[self heatMapColorLow] setHidden:toggle];
    [[self heatMapColorHigh] setHidden:toggle];
    [[self heatMapColorOrderButton] setHidden:toggle];
    [[self heatMapColorLabel] setHidden:toggle];
    




}


-(void)toggleBarControls:(BOOL)toggle  {
    [[self barSpaceControlLabel] setHidden:toggle];
    [[self barSpaceControlSlider] setHidden:toggle];

}


-(void)togglePieControls:(BOOL)toggle  {
    [[self useColumnsUseRows] setHidden:toggle];
    
}


-(IBAction)graphStack:(id)sender {
    [self setMode:StackViewMode];
    [self displayControls:StackViewMode];
    [myTabView showChart:[self chartAndTableTabView]];
}


-(IBAction)graphBar:(id)sender {
    
    [self setMode:BarViewMode];
    [self displayControls:BarViewMode];
}


-(IBAction)toggleColumnsRows:(id)sender {
    useColumns = !useColumns;
    NSLog(@"use columns is %hhd", useColumns);
    
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    [[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"NSApplicationCrashOnExceptions": @YES }];

    
    // TODO: Move this to where you establish a user session
    [self logUser];

    
   currentGraphId = [[NSProcessInfo processInfo] globallyUniqueString];
    currentGridColor = @"000000";
    // Insert code here to initialize your application
    
    
    
 
    [self setButtonImage:@"grid" :1];
    [self setButtonImageById:@"zero" :[self zeroStreamChart]];
    [self setButtonImageById:@"expand" :[self expandStreamChart]];
    [self setButtonImageById:@"wig" :[self wiggleStreamChart]];
    [self setButtonImageById:@"sil" :[self silStreamChart]];
    [self setButtonImageById:@"bar" :[self barChart]];
    [self setButtonImageById:@"pie" :[self pieChart]];
    [self setButtonImageById:@"grid" :[self gridHeatMapChart]];






    
    currentGraphBackground=@"FFFFFF";
    
   // [self displayControls:GraphViewMode];
    _barGap=5;
    
    purpleSwatch = [self createPurpleSwatch];
    greenSwatch = [self createGreenSwatch];
    goldSwatch = [self createGoldSwatch];
    blueSwatch = [self createBlueSwatch];
    redSwatch = [self createRedSwatch];

   
    NSString* jspath = [[NSBundle mainBundle] pathForResource:@"colorbrewer"
                                                       ofType:@"txt"];
    
    NSString* colorBrewer = [NSString stringWithContentsOfFile:jspath
                                     encoding:NSUTF8StringEncoding
                                        error:NULL];
    
     NSArray *colorBrewerRows = [colorBrewer componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
     stackNames = [[NSMutableArray alloc] init];
     colorStacks = [[NSMutableArray alloc] init];

    int i;
    for (i = 0; i < [colorBrewerRows count]; i++) {
        id line = [colorBrewerRows objectAtIndex:i];
        if ([line hasPrefix:@"var"]) {
            NSArray* parts = [line componentsSeparatedByString:@" = "];
            NSString* colorArrayName = [[[parts objectAtIndex:0] componentsSeparatedByString:@"var "] objectAtIndex:1];
            [stackNames addObject:colorArrayName];
            
            
             HCCPColorStack* colorStack = [[HCCPColorStack alloc] init];
            [colorStacks addObject:colorStack];
            
            NSArray* rgbs = [[[[[[parts objectAtIndex:1] componentsSeparatedByString:@"["] objectAtIndex:1] componentsSeparatedByString:@"]"] objectAtIndex:0] componentsSeparatedByString:@"','"];
            
            int j;
            for (j = 0; j < [rgbs count]; j++) {
                NSArray* colorVals =  [[[[[[rgbs objectAtIndex:j] componentsSeparatedByString:@"rgb("] objectAtIndex:1] componentsSeparatedByString:@")"] objectAtIndex:0] componentsSeparatedByString:@","];
                
                int red = [[colorVals objectAtIndex:0] intValue];
                int green = [[colorVals objectAtIndex:1] intValue];
                int blue = [[colorVals objectAtIndex:2] intValue];

                [colorStack add:[NSColor colorWithCalibratedRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:1.0]];
                
                
            }
            
                              
        }
    }
    int k=0;
     for (k = 0; k < [stackNames count]; k++) {
         NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:[stackNames objectAtIndex:k] action:@selector(applySwatch:) keyEquivalent:[[NSString alloc] initWithFormat:@"swatch %d", k]];
         [item setTag:k];
         
         NSString* itemImagePath = [[NSBundle mainBundle] pathForResource:[stackNames objectAtIndex:k]
                                                                  ofType:@"tiff"];
         
         NSImage* itemImage = [[NSImage alloc] initWithContentsOfFile:itemImagePath];
         [item setImage:itemImage];

         
         
         [[self colorSwatcheMenus] addItem:item];
         NSLog(@"here...");
     }
    NSLog(@"title %@", [[self colorSwatcheMenus] title]);
    
    [[self gridXText] setDelegate:self];

    
}



- (void) logUser {
    // TODO: Use the current user's information
    // You can call any combination of these three methods
 
}


- (BOOL)isHeatMapColorOrderReversed {
    return isHeatMapColorOrderReversed;
}

-(IBAction)toggleHeatMapColorOrder:(id)sender {
    isHeatMapColorOrderReversed = !isHeatMapColorOrderReversed;
    
    if (isHeatMapColorOrderReversed) {
        [[self heatMapColorHigh] setStringValue:@"Low"];
        [[self heatMapColorLow] setStringValue:@"High"];
    } else {
        [[self heatMapColorHigh] setStringValue:@"High"];
        [[self heatMapColorLow] setStringValue:@"Low"];

    }
    NSLog(@"isHeatMapColorOrderReversed is %i", isHeatMapColorOrderReversed);

    
    [self refreshChart];

}


- (IBAction)newDocument:(id)sender {
    NSMutableString* newRow = [[NSMutableString alloc] init];
    NSMutableString* newDocument = [[NSMutableString alloc] init];
    
    for (int i =0; i < 99; i++) {
        [newRow appendString:@","];
    }
    [newRow appendString:@""];
    
    for (int i =0; i < 99; i++) {
        [newDocument appendString:newRow];
        [newDocument appendString:@"\n"];
    }
    [newDocument appendString:newRow];
    
    [myTableView handleString:newDocument];
    
    
}


-(HCCPColorStack*)createPurpleSwatch {
    HCCPColorStack* _purpleSwatch = [[HCCPColorStack alloc] init];
    [_purpleSwatch add:[NSColor colorWithCalibratedRed:(184/255.0f) green:(146/255.0f) blue:(171/255.0f) alpha:1.0]];
    [_purpleSwatch add:[NSColor colorWithCalibratedRed:(141/255.0f) green:(103/255.0f) blue:(128/255.0f) alpha:1.0]];
    [_purpleSwatch add:[NSColor colorWithCalibratedRed:(128/255.0f) green:(91/255.0f) blue:(115/255.0f) alpha:1.0]];
    [_purpleSwatch add:[NSColor colorWithCalibratedRed:(135/255.0f) green:(98/255.0f) blue:(123/255.0f) alpha:1.0]];
    [_purpleSwatch add:[NSColor colorWithCalibratedRed:(92/255.0f) green:(55/255.0f) blue:(80/255.0f) alpha:1.0]];
    [_purpleSwatch add:[NSColor colorWithCalibratedRed:(155/255.0f) green:(117/255.0f) blue:(142/255.0f) alpha:1.0]];
    
    
    
    return _purpleSwatch;
}



-(HCCPColorStack*)createGreenSwatch {
    HCCPColorStack* _greenSwatch = [[HCCPColorStack alloc] init];
    [_greenSwatch add:[NSColor colorWithCalibratedRed:(169/255.0f) green:(198/255.0f) blue:(198/255.0f) alpha:1.0]];
    [_greenSwatch add:[NSColor colorWithCalibratedRed:(138/255.0f) green:(167/255.0f) blue:(167/255.0f) alpha:1.0]];
    [_greenSwatch add:[NSColor colorWithCalibratedRed:(109/255.0f) green:(138/255.0f) blue:(138/255.0f) alpha:1.0]];
    [_greenSwatch add:[NSColor colorWithCalibratedRed:(151/255.0f) green:(180/255.0f) blue:(180/255.0f) alpha:1.0]];
    [_greenSwatch add:[NSColor colorWithCalibratedRed:(119/255.0f) green:(148/255.0f) blue:(148/255.0f) alpha:1.0]];
    
    
    
    return _greenSwatch;
}



-(HCCPColorStack*)createGoldSwatch {
    HCCPColorStack* _goldSwatch = [[HCCPColorStack alloc] init];
    [_goldSwatch add:[NSColor colorWithCalibratedRed:(220/255.0f) green:(186/255.0f) blue:(158/255.0f) alpha:1.0]];
    [_goldSwatch add:[NSColor colorWithCalibratedRed:(174/255.0f) green:(141/255.0f) blue:(113/255.0f) alpha:1.0]];
    [_goldSwatch add:[NSColor colorWithCalibratedRed:(208/255.0f) green:(174/255.0f) blue:(146/255.0f) alpha:1.0]]; //d0ae92
    [_goldSwatch add:[NSColor colorWithCalibratedRed:(129/255.0f) green:(95/255.0f) blue:(67/255.0f) alpha:1.0]];
    [_goldSwatch add:[NSColor colorWithCalibratedRed:(140/255.0f) green:(106/255.0f) blue:(78/255.0f) alpha:1.0]];
    
    
    
    return _goldSwatch;
}

- (void)setGridEditMode:(BOOL)isGridEdit {
    isGridEditMode = isGridEdit;
}

-(HCCPColorStack*)createBlueSwatch {
    HCCPColorStack* _blueSwatch = [[HCCPColorStack alloc] init];
    [_blueSwatch add:[NSColor colorWithCalibratedRed:(95/255.0f) green:(95/255.0f) blue:(128/255.0f) alpha:1.0]];
    [_blueSwatch add:[NSColor colorWithCalibratedRed:(67/255.0f) green:(67/255.0f) blue:(100/255.0f) alpha:1.0]];
    [_blueSwatch add:[NSColor colorWithCalibratedRed:(161/255.0f) green:(161/255.0f) blue:(194/255.0f) alpha:1.0]];
    [_blueSwatch add:[NSColor colorWithCalibratedRed:(87/255.0f) green:(87/255.0f) blue:(120/255.0f) alpha:1.0]];
    [_blueSwatch add:[NSColor colorWithCalibratedRed:(208/255.0f) green:(208/255.0f) blue:(241/255.0f) alpha:1.0]];
    [_blueSwatch add:[NSColor colorWithCalibratedRed:(112/255.0f) green:(112/255.0f) blue:(145/255.0f) alpha:1.0]];

    
    return _blueSwatch;
}


-(HCCPColorStack*)createRedSwatch {
    HCCPColorStack* _redSwatch = [[HCCPColorStack alloc] init];
    [_redSwatch add:[NSColor colorWithCalibratedRed:(149/255.0f) green:(78/255.0f) blue:(78/255.0f) alpha:1.0]];
    [_redSwatch add:[NSColor colorWithCalibratedRed:(204/255.0f) green:(133/255.0f) blue:(133/255.0f) alpha:1.0]];
    
    return _redSwatch;
}


-(void)setButtonImage:(NSString*)gifName :(long)tag {
    NSString* silImagePath = [[NSBundle mainBundle] pathForResource:gifName
                                                             ofType:@"gif"];
    NSButton* silButton = [self.window.contentView viewWithTag:tag];
    NSImage* silImage = [[NSImage alloc] initWithContentsOfFile:silImagePath];
    [silButton setImage:silImage];
}


-(void)setButtonImageById:(NSString*)gifName :(NSButton*)button {
    NSString* silImagePath = [[NSBundle mainBundle] pathForResource:gifName
                                                             ofType:@"gif"];
    NSImage* silImage = [[NSImage alloc] initWithContentsOfFile:silImagePath];
    [button setImage:silImage];
}

- (BOOL)validateMenuItem:(NSMenuItem *)item 
{
    NSLog(@"validating UI %@", item);
    return YES;
}


-(NSURL*)getCurrentGraphUrl {
    
    NSString* graphFile = [[@"file:///tmp/" stringByAppendingString: [self getCurrentGraphId]] stringByAppendingString:@".html"];
    
    NSURL *baseURL = [NSURL URLWithString:graphFile];
    return baseURL;
}


- (IBAction)createGraph:(id)pId {
    if (pId != nil){
        [myTableView createGraph:(int)[pId tag]];
    } else {
        [myTableView createGraph:-1];
    
    }
    

}


- (void)initializeRowBackgroundArray:(NSInteger*)tableSize {
    rowColors = [[NSMutableArray alloc] initWithCapacity:tableSize];
    for (int i = 0; i < (int)tableSize; i++) {
        [rowColors addObject:[NSColor redColor]];
    }
}


- (NSColor*)getRowBackground:(NSInteger*)rowId {
    return [rowColors objectAtIndex:rowId];
}

- (NSArray*) getDocumentColors {
    return rowColors;
}


- (BOOL)getIsShowHeatMapLegend {
    return isShowHeatMapLegend;
}

-(IBAction)brightnessFilterDialog:(id)sender {
    NSLog(@"window open");
    [NSApp beginSheet:[self brightnessPanel]
       modalForWindow:[self window]
        modalDelegate:self
       didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
          contextInfo:nil];
    NSString* value;
    if (brightness < 1) {
        value = [[NSString alloc] initWithFormat:@"-%d", (int)((1 - brightness) * 100)];
    } else if (brightness == 0) {
        value = @"0";
    } else {
        value = [[NSString alloc] initWithFormat:@"%d", (int)((brightness - 1) * 100)];
    }
    [[self brightnessField] setStringValue:[[NSString alloc] initWithFormat:@"%@", value]];

    

}

- (void) didEndSheet: (NSAlert *) alert returnCode: (NSInteger) code contextInfo: (id) contextInfo {
}

-(IBAction)exportData:(id)sender {

    
    NSSavePanel *dataSavePanel	= [NSSavePanel savePanel];
    [dataSavePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"csv", nil]];
    [dataSavePanel setExtensionHidden:NO];
    
    
    int tvarInt	= [dataSavePanel runModal];
    
    if(tvarInt == NSOKButton){
     	NSLog(@"doSaveAs we have an OK button");
    } else if(tvarInt == NSCancelButton) {
     	NSLog(@"doSaveAs we have a Cancel button");
     	return;
    } else {
     	NSLog(@"doSaveAs tvarInt not equal 1 or zero = %3d",tvarInt);
     	return;
    } // end if
    
    NSMutableString* document = [[NSMutableString alloc] init];
    NSArray* data = [myTableView getData];
    
    NSLog(@"data? %@", data);

    
    for (int i = 0; i < [data count]; i++) {
        NSArray* record = [data objectAtIndex:i];
        for (int j=0; j < [record count]; j++) {
            int mappedIndex = [[[myTableView getColumnOrder] objectAtIndex:j] intValue];
            [document appendString:[record objectAtIndex:mappedIndex]];
            if (j < ([record count]-1)) {
                [document appendString:@","];
            }

        }
        [document appendString:@"\n"];
    }
    
    NSLog(@"csv: %@", document);
NSLog(@"saving to? %@", [dataSavePanel URL]);
    
        [document writeToURL:[dataSavePanel URL] atomically:NO encoding:NSUTF8StringEncoding error:nil];
    

    
}




-(IBAction)captureImage:(id)sender {
    
    NSSavePanel *imageSavePanel	= [NSSavePanel savePanel];
    [imageSavePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"png", nil]];
    [imageSavePanel setExtensionHidden:NO];
    
    
    int tvarInt	= [imageSavePanel runModal];
    
    if(tvarInt == NSOKButton){
     	NSLog(@"doSaveAs we have an OK button");
    } else if(tvarInt == NSCancelButton) {
     	NSLog(@"doSaveAs we have a Cancel button");
     	return;
    } else {
     	NSLog(@"doSaveAs tvarInt not equal 1 or zero = %3d",tvarInt);
     	return;
    } // end if
    
    NSString * tvarDirectory = [imageSavePanel directory];
    NSLog(@"doSaveAs directory = %@",tvarDirectory);
    
    NSString * tvarFilename = [imageSavePanel filename];
    NSLog(@"doSaveAs filename = %@",tvarFilename);
    
    
    
    
    
    NSLog(@"snappers");
    NSView *webFrameViewDocView = [[[myWebView mainFrame] frameView] documentView];
	NSRect cacheRect = [webFrameViewDocView bounds];
    NSBitmapImageRep *bitmapRep = [webFrameViewDocView bitmapImageRepForCachingDisplayInRect:cacheRect];
	[webFrameViewDocView cacheDisplayInRect:cacheRect toBitmapImageRep:bitmapRep];
    //NSImage* image = [[NSImage alloc] initWithCGImage:[bitmapRep CGImage] size:cacheRect.size];
    
    NSData *data = [bitmapRep representationUsingType: NSPNGFileType properties: nil];
    [data writeToURL:[imageSavePanel URL] atomically: NO];
    NSLog(@"done %@", webFrameViewDocView);

    
}


- (void)setTableView:(HCCPTableView*)tableView {
    myTableView=tableView;
    NSLog(@"setting table view: %@", myTableView);

}

- (void)setTabView:(HCCPTabView*)tabView {
  //  if (tabView == nil) {
     myTabView = tabView;   
    //} else {
      //  NSLog(@"tab view already defined...");
   // }
}

- (void)setWebView:(WebView*)webView {
    myWebView =webView;
    
}

- (void)setMode:(ModeType)mode {
    NSLog(@"bview: %ld", BarViewMode);
    NSLog(@"gview: %ld", GraphViewMode);
    NSLog(@"sview: %ld", StackViewMode);
    
    NSLog(@"called with: %ld", mode);
    
    

    _mode=mode;
}



-(IBAction)selectChartBackgroundColor:(id)sender {
    NSColorWell * colorChooser = sender;
    if (![colorChooser isActive])  {
        [colorChooser activate:YES];
    }
    NSLog(@"choosing color: %@", [colorChooser color]);
    NSLog(@"current mode: %ld", _mode);
    
    NSString* selectedColor = [[[HCCPColorStack alloc] init] colorToHexString:[colorChooser color]];
    if (_mode == StackViewMode) {
        if (isGridEditMode) {
            currentGridColor = selectedColor;
        } else {
            currentGraphBackground = selectedColor;
        
        }
    } else if (_mode == GraphViewMode) {
        [self setSelectedRowBackground:[colorChooser color]];
    }
    
      [self refreshChart];

    
    
}

- (void)setSelectedRow:(NSInteger*)selectedRow {
    currentSelectedRow = selectedRow;
}

- (void)setSelectedRowBackground:(NSColor*)color {
    
    [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSLog(@"selrows idx: %d", idx);
          [rowColors replaceObjectAtIndex:idx withObject:color];
    }];
    
    [rowColors replaceObjectAtIndex:currentSelectedRow withObject:color];
}



-(NSString*)getCurrentGraphBackground {
    return currentGraphBackground;
}


-(NSString*)getCurrentGraphId {
    return currentGraphId;
}


-(void)application:(NSApplication *)sender openFiles:(NSArray *)filenames
{
    if ([filenames count] == 1) {
        NSLog(@"here...");
        NSURL* url = [NSURL URLWithString: [@"file://" stringByAppendingString:[filenames objectAtIndex:0]]];
        NSLog(@"%@", url);
        
        [myTableView handleFile:url];
        NSLog(@"there...");
    }
    
}


-(IBAction)setBarGap:(id)sender {
    
    NSSlider* slider = sender;
    _barGap = [slider doubleValue];
    NSLog(@"bar gap is %ld", _barGap);
    NSLog(@"mode is %ld", _mode);
    
    [[self chartAndTableTabView] selectLastTabViewItem:sender];
    
    HCCPBarGraphWriter* writer = [[HCCPBarGraphWriter alloc] init];
    [writer writeToHtml:[myTableView getData]:[myTableView getColumnOrder]:[self getDocumentColors]:[self getCurrentGraphUrl]:@"bar":[self getCurrentGraphBackground]:[self getBarGap]];
    [myWebView reload:self];
    
}

- (long) getBarGap {
    return _barGap;
}


-(IBAction)setHeatMapBucketRange:(id)sender {
    NSSlider* slider = sender;
    _heatMapBuckets = [slider doubleValue];
    [self refreshChart];
}

- (long) getHeatMapBucketCount {
    if (_heatMapBuckets <= 0) {
        return 5;
    } else {
        return _heatMapBuckets;
    }
}



- (void)setSelectedRowIndexes:(NSIndexSet*)selectedRowIndexes {
    currentSelectedRows = selectedRowIndexes;
}


-(IBAction)applySwatch:(id)sender {
    
    
    [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        HCCPColorStack* colorStack = [colorStacks objectAtIndex:[sender tag]];
        [rowColors replaceObjectAtIndex:idx withObject:[colorStack pop]];
         
    }];
   

   
}

-(IBAction)reverseColumnOrder:(id)sender {
    
     NSLog(@"before reverse %@", [myTableView getColumnOrder]);
    int columnCount = [[myTableView getColumnOrder] count];
    for (int i=1; i < columnCount; i++) {
        [myTableView moveColumn:(columnCount -1) toColumn:i];
    }
    
    NSLog(@"after reverse %@", [myTableView getColumnOrder]);
    
}


- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    NSLog(@"selected data tab! xx");
}

- (NSTabView*) getTabView {
    return myTabView;
}

- (ModeType)getMode {
    return _mode;
}






- (NSString *)getGraphType:(int)graphTypeId {
    NSString *graphType;
    switch (graphTypeId)
    
    {
        case 6:
            
            graphType = @"silhouette";
            
            break;
            
        case 5:
            
            graphType = @"wiggle";
            
            break;
            
        case 4:
            
            graphType = @"expand";
            
            break;
            
        case 3:
            
            graphType = @"zero";
            
            break;
            
        case 8:
            
            graphType = @"bar";
            
            break;
            
            
        case 10:
            
            graphType = @"heatmap";
            
            break;
            
        case 11:
            
            graphType = @"bar";
            
            break;
            
        case 12:
            
            graphType = @"pie";
            
            break;
            
        default:
            
            graphType = @"silhouette";
            
            
            break;
            
    }
    return graphType;
}



- (ModeType)getGraphMode:(int)graphTypeId {
    switch (graphTypeId)
    
    {
        case 6:
            
            return StackViewMode;
            break;
            
        case 5:
            
            return StackViewMode;

            break;
            
        case 4:
            
            return StackViewMode;
            break;
            
        case 3:
            
            return StackViewMode;
            break;
            
        case 8:
            
            return BarViewMode;

            
            break;
            
            
        case 11:
            
            return BarViewMode;
            
            break;
            
            
        case 10:
            
            return HeatMapMode;
            
            break;
        
        case 12:
            
            return PieMode;
            
            break;
            
        default:
            
            return StackViewMode;
            
            
            break;
            
    }
}


-(IBAction)heatMapLegendCheck:(id)pId {
    NSButton* legendCheck = pId;
    isShowHeatMapLegend = [legendCheck state];
    [self refreshChart];
}

-(IBAction)brightnessSlider:(id)sender {
    
    NSSlider* slider = sender;
    int sliderValue =  [slider intValue];
    [self updateBrightness:sliderValue];
    
    [[self brightnessField] setStringValue: [[NSString alloc] initWithFormat:@"%i", sliderValue]];

    

}

-(IBAction)brightnessField:(id)sender {
    NSTextField *brightnessField = sender;
    [self updateBrightness:[brightnessField intValue]];
}

-(float)getBrightness {
    return brightness;
}

-(void)updateBrightness:(int)value {
    
    NSLog(@"brightness: %i", value);
    
    if (value < 0) {
        brightness = 1 + (value * 0.01);
    } else {
        brightness = 1 + (value * 0.01);
    }
    
    //brightness = [slider intValue];
    NSLog(@"brightness %f", brightness);
    [self refreshChart];

}


-(IBAction)applyBrightness:(id)sender {
    
    [[self brightnessPanel] close];
    [NSApp endSheet:[self brightnessPanel]];
}


-(IBAction)cancelBrightness:(id)sender {
    [[self brightnessPanel] close];
    [NSApp endSheet:[self brightnessPanel]];
    
}




-(IBAction)gridTickStepperXYAction:(id)pId {
    NSLog(@"tick action %d",  [pId intValue]);
    int dirValue = [pId intValue];
    if ([pId tag] == 1) {
        if (dirValue < gridXStepValue) {
            [[self gridXText] setIntValue:[[self gridXText] intValue] - 1];
        } else {
            [[self gridXText] setIntValue:[[self gridXText] intValue] + 1];
        }
        gridXStepValue = dirValue;
    }

    if ([pId tag] == 2) {
        if (dirValue < gridyStepValue) {
            [[self gridYText] setIntValue:[[self gridYText] intValue] - 1];
        } else {
            [[self gridYText] setIntValue:[[self gridYText] intValue] + 1];
        }
        gridyStepValue = dirValue;
    }
    
    [self refreshChart];
    
    
}

-(IBAction)gridTickerCheck:(id)pId {
    NSButton* gridcheck = pId;
    NSLog(@"grid checkbox state %ld", [gridcheck state]);
    drawGrid = [gridcheck state];
    NSLog(@"draw grid state: %@", drawGrid);
 
    HCCPStreamGraphWriter* writer = [[HCCPStreamGraphWriter alloc] init];
    [writer writeToHtml:[myTableView getData]:[myTableView getColumnOrder]:[self getDocumentColors]:[self getCurrentGraphUrl]:[self getCurrentGraphType]:[self getCurrentGraphBackground]:drawGrid:[[self gridXText] integerValue]:[[self gridYText] integerValue]:currentGridColor:brightness];
    [myWebView reload:self];
    
}

-(void)refreshChart {
    
    NSString* graphType = [self getCurrentGraphType];
    
    if ([graphType isEqualToString:@"bar"]) {
        HCCPBarGraphWriter* writer = [[HCCPBarGraphWriter alloc] init];
        [writer writeToHtml:[myTableView getData]:[myTableView getColumnOrder]:[self getDocumentColors]:[self getCurrentGraphUrl]:graphType:[self getCurrentGraphBackground]:[self getBarGap]];
    } else if ([graphType isEqualToString:@"heatmap"]) {
        HCCPHeatMapGraphWriter* writer = [[HCCPHeatMapGraphWriter alloc] init];
        [writer writeToHtml:[myTableView getData]:[myTableView getColumnOrder]:[self getDocumentColors]:[self getCurrentGraphUrl]:graphType:YES:YES:YES:[self getIsShowHeatMapLegend]:[self getHeatMapBucketCount]:[self getHeatMapPalette]:[self isHeatMapColorOrderReversed]];
        
        
    } else {
        
        HCCPStreamGraphWriter* writer = [[HCCPStreamGraphWriter alloc] init];
        [writer writeToHtml:[myTableView getData]:[myTableView getColumnOrder]:[self getDocumentColors]:[self getCurrentGraphUrl]:graphType:[self getCurrentGraphBackground]:[self getDrawGrid]:[[self gridXText] integerValue]:[[self gridYText] integerValue]:[self getCurrentGridColor]:[self getBrightness]];
        
    }
    
    
    [myWebView reload:self];
    
}


-(IBAction)setHeatMapColorSelection:(id)sender {
    
    // http://youtu.be/5klUbOvaBS4   <-- Haslam
    
    
    
    NSString* palettes[29] = {@"Blues", @"Greens", @"Greys", @"Oranges", @"Purples", @"Reds", @"BuGn", @"BuPu", @"GnBu", @"OrRd", @"PuBu", @"PuBuGn", @"PuRd", @"RdPu", @"YlGn", @"YlGnBu", @"YlOrBr", @"YlOrRd", @"BrBG", @"PiYG", @"PRGn", @"PuOr", @"RdBu", @"RdGy", @"RdYlBu", @"RdYlGn", @"Spectral", @"Paired", @"Set3"};
    
    
    NSPopUpButton* button = sender;    
    int tag = [[button selectedItem] tag];
    currentHeatMapPalette = palettes[tag - 1];
    [self refreshChart];
 
    
    
}

-(NSString*)getHeatMapPalette {
    if (currentHeatMapPalette == nil) {
        currentHeatMapPalette = @"YlGnBu";
    }
    return currentHeatMapPalette;
}


-(BOOL)getDrawGrid {
    return drawGrid;
}

- (NSString *)getCurrentGraphType {
    return currentGraphType;
}
- (void)setCurrentGraphType:(NSString*)curGraphType {
    currentGraphType=curGraphType;
}

- (void)controlTextDidChange:(NSNotification *)notification {
    [self refreshChart];
}

-(BOOL)getGridEditMode {
    return isGridEditMode;
}

-(NSString*)getCurrentGridColor {
    return currentGridColor;
}

@end
