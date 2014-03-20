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


@implementation HCCPAppDelegate



- (void)displayControls:(ModeType)mode {
   
    switch (mode)
    
    {
        case GraphViewMode:
            
           [[self.window.contentView viewWithTag:3] setHidden:YES];
           [[self.window.contentView viewWithTag:4] setHidden:YES];
           [[self.window.contentView viewWithTag:5] setHidden:YES];
           [[self.window.contentView viewWithTag:6] setHidden:YES];
           [[self.window.contentView viewWithTag:8] setHidden:YES];
           [[self.window.contentView viewWithTag:9] setHidden:YES];

 

            
            break;
            
        case BarViewMode:
            [[self.window.contentView viewWithTag:3] setHidden:YES];
            [[self.window.contentView viewWithTag:4] setHidden:YES];
            [[self.window.contentView viewWithTag:5] setHidden:YES];
            [[self.window.contentView viewWithTag:6] setHidden:YES];
            
            [[self.window.contentView viewWithTag:8] setHidden:NO];
            [[self.window.contentView viewWithTag:9] setHidden:NO];


 
            
            break;
            
        case StackViewMode:
            
            [[self.window.contentView viewWithTag:3] setHidden:NO];
            [[self.window.contentView viewWithTag:4] setHidden:NO];
            [[self.window.contentView viewWithTag:5] setHidden:NO];
            [[self.window.contentView viewWithTag:6] setHidden:NO];
            
            [[self.window.contentView viewWithTag:8] setHidden:YES];
            [[self.window.contentView viewWithTag:9] setHidden:YES];


            
            break;
            
        default:
            
            
            
            break;
            
    }

    
    
}



-(IBAction)graphStack:(id)sender {
    [self setMode:StackViewMode];
    [self displayControls:StackViewMode];
    [myTabView selectLastTabViewItem:sender];
}
-(IBAction)graphBar:(id)sender {
    
    [self setMode:BarViewMode];
    [self displayControls:BarViewMode];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    
   currentGraphId = [[NSProcessInfo processInfo] globallyUniqueString];
    // Insert code here to initialize your application
    
    
    
 
    [self setButtonImage:@"grid" :1];
    [self setButtonImage:@"bar" :2];
    [self setButtonImage:@"zero" :3];
    [self setButtonImage:@"expand" :4];
    [self setButtonImage:@"wig" :5];
    [self setButtonImage:@"sil" :6];
    [self setButtonImage:@"sil" :7];
    [self setButtonImage:@"bar" :8];





    
    currentGraphBackground=@"FFFFFF";
    
    [self displayControls:GraphViewMode];
    _barGap=5;
    
    purpleSwatch = [self createPurpleSwatch];
    greenSwatch = [self createGreenSwatch];
    goldSwatch = [self createGoldSwatch];
    blueSwatch = [self createBlueSwatch];
    redSwatch = [self createRedSwatch];

    

    
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
    
    [myTableView createGraph:pId];
    

}


- (void)initializeRowBackgroundArray:(NSInteger*)tableSize {
    rowColors = [[NSMutableArray alloc] initWithCapacity:tableSize];
    for (int i = 0; i < tableSize; i++) {
        [rowColors addObject:[NSColor redColor]];
    }
}


- (NSColor*)getRowBackground:(NSInteger*)rowId {
    return [rowColors objectAtIndex:rowId];
}

- (NSArray*) getDocumentColors {
    return rowColors;
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
            [document appendString:[record objectAtIndex:j]];
            if (j < ([record count]-1)) {
                [document appendString:@","];
            }

        }
        [document appendString:@"\n"];
    }
    
    NSLog(@"csv: %@", document);
NSLog(@"saving to? %@", [dataSavePanel URL]);
    
        [document writeToURL:[dataSavePanel URL] atomically:NO encoding:NSUTF8StringEncoding error:nil];
    
    //[@"sss" writeToURL:[dataSavePanel URL] atomically: NO];

    
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
    myTabView = tabView;
}

- (void)setWebView:(WebView*)webView {
    myWebView =webView;
    
}

- (void)setMode:(ModeType)mode {
    _mode=mode;
}



-(IBAction)selectChartBackgroundColor:(id)sender {
    NSColorWell * colorChooser = sender;
    NSLog(@"choosing color: %@", [colorChooser color]);
    NSLog(@"current mode: %ld", _mode);
    
    NSString* selectedColor = [[[HCCPColorStack alloc] init] colorToHexString:[colorChooser color]];
    if (_mode == StackViewMode) {
        currentGraphBackground = selectedColor;
    } else if (_mode == GraphViewMode) {
        [self setSelectedRowBackground:[colorChooser color]];
    }
    
    
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
    [myTabView selectLastTabViewItem:sender];
    
}

- (long) getBarGap {
    return _barGap;
}


- (void)setSelectedRowIndexes:(NSIndexSet*)selectedRowIndexes {
    currentSelectedRows = selectedRowIndexes;
}


-(IBAction)applySwatch:(id)sender {
    switch ([sender tag])
    
    {
        {case 12:
            [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                [rowColors replaceObjectAtIndex:idx withObject:[purpleSwatch pop]];
            }];
            break;
        }
        {case 13:
            [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                [rowColors replaceObjectAtIndex:idx withObject:[greenSwatch pop]];
            }];
            break;
        }

        {case 14:
            [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                [rowColors replaceObjectAtIndex:idx withObject:[goldSwatch pop]];
            }];
            break;
        }

        {case 15:
            [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                [rowColors replaceObjectAtIndex:idx withObject:[blueSwatch pop]];
            }];
            break;
        }
            
        {case 16:
            [currentSelectedRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                [rowColors replaceObjectAtIndex:idx withObject:[redSwatch pop]];
            }];
            break;
        }
    }
    
   

   
}



@end
