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
        colors = [[NSMutableArray alloc] init];
        colorStack = [[HCCPColorStack alloc] init];
        
        //pinks
        [colorStack add:[NSColor colorWithCalibratedRed:(255/255.0f) green:(247/255.0f) blue:(243/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(254/255.0f) green:(235/255.0f) blue:(226/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(253/255.0f) green:(224/255.0f) blue:(221/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(252/255.0f) green:(197/255.0f) blue:(192/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(251/255.0f) green:(180/255.0f) blue:(185/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(250/255.0f) green:(159/255.0f) blue:(181/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(247/255.0f) green:(104/255.0f) blue:(161/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(221/255.0f) green:(52/255.0f) blue:(151/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(174/255.0f) green:(1/255.0f) blue:(126/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(122/255.0f) green:(1/255.0f) blue:(119/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(73/255.0f) green:(0/255.0f) blue:(106/255.0f) alpha:1.0]];

        
        //blues
        [colorStack add:[NSColor colorWithCalibratedRed:(247/255.0f) green:(251/255.0f) blue:(255/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(222/255.0f) green:(235/255.0f) blue:(247/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(198/255.0f) green:(219/255.0f) blue:(239/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(158/255.0f) green:(202/255.0f) blue:(225/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(107/255.0f) green:(174/255.0f) blue:(214/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(66/255.0f) green:(146/255.0f) blue:(198/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(33/255.0f) green:(113/255.0f) blue:(181/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(8/255.0f) green:(81/255.0f) blue:(156/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(8/255.0f) green:(48/255.0f) blue:(107/255.0f) alpha:1.0]];

        //greens
        [colorStack add:[NSColor colorWithCalibratedRed:(247/255.0f) green:(252/255.0f) blue:(245/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(229/255.0f) green:(245/255.0f) blue:(224/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(199/255.0f) green:(233/255.0f) blue:(192/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(161/255.0f) green:(217/255.0f) blue:(155/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(116/255.0f) green:(196/255.0f) blue:(118/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(65/255.0f) green:(171/255.0f) blue:(93/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(35/255.0f) green:(139/255.0f) blue:(69/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(0/255.0f) green:(109/255.0f) blue:(44/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(0/255.0f) green:(68/255.0f) blue:(27/255.0f) alpha:1.0]];

        //reds
        [colorStack add:[NSColor colorWithCalibratedRed:(255/255.0f) green:(245/255.0f) blue:(240/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(254/255.0f) green:(224/255.0f) blue:(210/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(252/255.0f) green:(187/255.0f) blue:(161/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(252/255.0f) green:(146/255.0f) blue:(114/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(251/255.0f) green:(106/255.0f) blue:(74/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(239/255.0f) green:(59/255.0f) blue:(44/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(203/255.0f) green:(24/255.0f) blue:(29/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(165/255.0f) green:(15/255.0f) blue:(21/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(103/255.0f) green:(0/255.0f) blue:(13/255.0f) alpha:1.0]];


        //brownish
        [colorStack add:[NSColor colorWithCalibratedRed:(255/255.0f) green:(245/255.0f) blue:(235/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(254/255.0f) green:(230/255.0f) blue:(206/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(253/255.0f) green:(208/255.0f) blue:(162/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(253/255.0f) green:(174/255.0f) blue:(107/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(241/255.0f) green:(105/255.0f) blue:(19/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(217/255.0f) green:(72/255.0f) blue:(1/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(166/255.0f) green:(54/255.0f) blue:(3/255.0f) alpha:1.0]];
        [colorStack add:[NSColor colorWithCalibratedRed:(127/255.0f) green:(39/255.0f) blue:(4/255.0f) alpha:1.0]];


















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
    
    return [rows count];
}



- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex {
    NSLog(@"foo %@", anObject);
}


- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(int)row
{
    [tableView setGridStyleMask:(NSTableViewSolidVerticalGridLineMask | NSTableViewSolidHorizontalGridLineMask)];
    
    if ([[tableColumn identifier] intValue] == 0) {
        
        NSTextFieldCell* cell = [tableColumn dataCellForRow:row];
        [cell setDrawsBackground:true];
        NSColor* cellColor=[colors objectAtIndex:row];
        [cellColor set];
        [cell setBackgroundColor:cellColor];
//        [colors replaceObjectAtIndex:row withObject:cellColor];
    }
    return [[rows objectAtIndex:row] objectAtIndex:[[tableColumn identifier] intValue]];
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
        for (int i=0; i < [fileRows count] -1; i++) {
             NSString* row = [fileRows objectAtIndex:i];
             NSArray* columns = [row componentsSeparatedByString:@","];
            [rows addObject:columns];
            [colors addObject:[colorStack pop]];
            NSLog(@"adding row");
        }
        
        
    }
    
    NSArray* tableCols = [myTableView tableColumns];
    for (int x=0; x < [tableCols count]; x++) {
        NSLog(@"removing column");

        [myTableView removeTableColumn:[tableCols objectAtIndex:x]];
    }
    
    if ([rows count] > 0) {
        NSArray* headers = [rows objectAtIndex:0];
        NSUInteger columnCount = [headers count];
         for (int x=0; x < columnCount; x++) {
             NSTableColumn* column = [[NSTableColumn alloc] initWithIdentifier: [NSString stringWithFormat:@"%i", x]];
             [[column headerCell] setStringValue:[headers objectAtIndex:x]];
             [myTableView addTableColumn:column];
         }
    }
    
    
    NSLog(@"rows size is: %ld", [rows count]);
    [myTableView reloadData];

}




@end
