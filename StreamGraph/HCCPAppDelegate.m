//
//  HCCPAppDelegate.m
//  StreamGraph
//
//  Created by Ian Brown on 6/14/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPAppDelegate.h"

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


@end
