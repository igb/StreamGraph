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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    
   currentGraphId = [[NSProcessInfo processInfo] globallyUniqueString];
    // Insert code here to initialize your application
    
    
    
 
    [self setButtonImage:@"expand" :4];
    [self setButtonImage:@"sil-graph" :5];
    currentGraphBackground=@"FFFFFF";
    
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





-(IBAction)selectChartBackgroundColor:(id)sender {
    NSColorWell * colorChooser = sender;
    currentGraphBackground = [[[HCCPColorStack alloc] init] colorToHexString:[colorChooser color]];
    
    
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



@end
