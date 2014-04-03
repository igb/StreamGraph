//
//  HCCPControlPanelView.m
//  StreamGraph
//
//  Created by Ian Brown on 3/30/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPControlPanelView.h"
#import "HCCPAppDelegate.h"

@implementation HCCPControlPanelView

HCCPAppDelegate* delegate;

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    NSLog(@"selected data tab!");

    
    switch ([[tabViewItem identifier] intValue]) {
        case 1:
            NSLog(@"trying...!");
            NSLog(@"trying 2...!");
            
            
            [(HCCPTabView*)[delegate getTabView] showTableData:self];
            
            NSLog(@"sent!");

            break;
        case 2:
            
            [(HCCPTabView*)[delegate getTabView] showChart:self];
            
            NSLog(@"sent!");
            
            break;
            
        case 3:
            
            NSLog(@"mode is: %ld", [delegate getMode]);
            
            NSLog(@"sent!");
            
            break;
        default:
            break;
    }
}

-(void) awakeFromNib {

    delegate = [[NSApplication sharedApplication] delegate];
}
@end
