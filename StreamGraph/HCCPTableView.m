//
//  HCCPTableView.m
//  StreamGraph
//
//  Created by Ian Brown on 6/15/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPTableView.h"

@implementation HCCPTableView



- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        rows = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}


- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    myTableView=tableView;
    NSLog(@"calling numrows...%ld", [rows count]);
    
    return [rows count];
}



- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex {
    NSLog(@"foo %@", anObject);
}


- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(int)row
{
    NSLog(@"col: %@ row: %d", [tableColumn identifier] , row);

     NSLog(@"cell? %@",  [tableColumn dataCellForRow:row] );
    
    NSTextFieldCell* cell = [tableColumn dataCellForRow:row];
    [cell setDrawsBackground:true];
    float colorFloat = (row * (255/[rows count]));
    NSColor* cellColor=[NSColor colorWithCalibratedRed:(50/255.0f) green:(50/255.0f) blue:(colorFloat/255.0f) alpha:1.0];
    [cellColor set];
    [cell setBackgroundColor:cellColor];
     return @"foo";
}


                               
                               
                               
- (IBAction)openCsvFile:(id)sender;
{
    NSOpenPanel *openPanel  = [NSOpenPanel openPanel];
    NSArray *fileTypes = [NSArray arrayWithObjects:@"csv",nil];
    NSInteger result  = [openPanel runModalForDirectory:NSHomeDirectory() file:nil types:fileTypes ];
    if(result == NSOKButton){
        rows = [[NSMutableArray alloc] init];
        NSString* fileContents = [NSString stringWithContentsOfURL:[openPanel URL]];
        
        // http://stackoverflow.com/questions/5140391/for-loop-in-objective-c
        NSArray* fileRows = [fileContents componentsSeparatedByString:@"\n"];
        for (int i=0; i < [fileRows count]; i++) {
             NSString* row = [fileRows objectAtIndex:i];
             NSArray* columns = [row componentsSeparatedByString:@","];
            [rows addObject:columns];
            NSLog(@"adding row");
        }
        
        
    }
    
    NSArray* tableCols = [myTableView tableColumns];
    for (int x=0; x < [tableCols count]; x++) {
        NSLog(@"removing column");

        [myTableView removeTableColumn:[tableCols objectAtIndex:x]];
    }
    
    NSLog(@"rows size is: %ld", [rows count]);
    [myTableView reloadData];

}




@end
