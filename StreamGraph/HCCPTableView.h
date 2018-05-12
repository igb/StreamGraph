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
    NSMutableArray *columnOrder;
    NSMutableArray *colors;
    NSTableView *myTableView;
    HCCPColorStack *colorStack;
    BOOL updateData;

    
}

 - (void)createGraph:(int)graphType;
 - (void)handleFile:(NSURL*)fileUrl;
 - (void)handleString:(NSString*) dataString;
 - (void)switchRowsAndColumns;

- (NSArray*)getData;
- (NSArray*)getColumnOrder;



@end
