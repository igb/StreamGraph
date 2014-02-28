//
//  HCCPTableView.h
//  StreamGraph
//
//  Created by Ian Brown on 6/15/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HCCPColorStack.h"



@interface HCCPTableView : NSTableView
{

    NSMutableArray *rows;
    NSMutableArray *colors;
    NSTableView *myTableView;
    HCCPColorStack *colorStack;
   
    
}

 - (IBAction)createGraph:(id)pId;
 - (void)handleFile:(NSURL*)fileUrl;


@end
