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
    // Insert code here to initialize your application
}

- (BOOL)validateMenuItem:(NSMenuItem *)item 
{
    NSLog(@"validating UI %@", item);
    return YES;
}

- (IBAction)createGraph:(id)pId {
    //  [myTableView removeFromSuperview];
    HCCPStreamGraphWriter* writer = [[HCCPStreamGraphWriter alloc] init];
  //  [writer writeToHtml:rows:colors];
    
}


-(IBAction)showView1:(id)sender
{
   // View1Controller * controller = [[View1Controller alloc]init];
  //  [self setMainViewTo:controller];
}
-(IBAction)showView2:(id)sender
{
  //  View2Controller * controller = [[View2Controller alloc]init];
   // [self setMainViewTo:controller];
}


@end
