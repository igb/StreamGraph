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
    //  [myTableView removeFromSuperview];
    HCCPStreamGraphWriter* writer = [[HCCPStreamGraphWriter alloc] init];
  //  [writer writeToHtml:rows:colors];
    

}

- (void)setTableView:(HCCPTableView*)tableView {
    myTableView=tableView;
    NSLog(@"setting table view: %@", myTableView);
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
