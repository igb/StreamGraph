//
//  HCCPHeatMapGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 4/26/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPHeatMapGraphWriter.h"

@implementation HCCPHeatMapGraphWriter

-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(BOOL)constrainCells :(BOOL)displayLabels :(BOOL)useFirstColumnAndRowForLabels :(BOOL)displayLegend {
    
    
    NSOutputStream *stream = [[NSOutputStream alloc]  initWithURL:fileUrl append:NO];
    [stream open];
    
    
    
    NSMutableString* document = [[NSMutableString alloc] init];
    
    
    
    
    [self writeStringToStream:stream :[self getSection:@"header"]];
    [self writeStringToStream:stream :@"<script>"];
    [self writeStringToStream:stream :[self getD3js]];
    [self writeStringToStream:stream :@"</script>"];
    [self writeStringToStream:stream :[self getSection:@"section0"]];
    [self writeStringToStream:stream :@"FFFFFF"];
    [self writeStringToStream:stream :[self getSection:@"section01"]];
   
    
    int i_start_pos = 0;
    int j_start_pos = 0;
    
    if (useFirstColumnAndRowForLabels) {
        i_start_pos=1;
        j_start_pos=1;
        
        NSMutableString* xLabels = [[NSMutableString alloc] initWithString:@"var xLabels = ["];
        NSMutableString* yLabels = [[NSMutableString alloc] initWithString:@"\nvar yLabels = ["];
        
        for (int i = i_start_pos; i < [data count]; i++) {
            NSArray* row = [data objectAtIndex:i];
            [yLabels appendFormat:@"\"%@\"", [row objectAtIndex:0]];
            if (i < ([data count] - 1)) {
                [yLabels appendString:@", "];
            }
            
        }
        [yLabels appendString:@"];\n"];
        
        NSArray* row = [data objectAtIndex:0];
        for (int i = 1; i < [row count]; i++) {
            [xLabels appendFormat:@"\"%@\"", [row objectAtIndex:i]];
            if (i < ([row count] - 1)) {
                [xLabels appendString:@", "];
            }

        }
        [xLabels appendString:@"];\n"];
        
        [document appendString:xLabels];
        [document appendString:yLabels];
        
        [document appendString:@"\nx_size=xLabels.length;\ny_size=yLabels.length;\n"];
    } else {
       [document appendFormat:@"\nx_size=%lu;\ny_size=y%lu; //hardcoded by data size\n", (unsigned long)[[data objectAtIndex:0] count], (unsigned long)[data count]];
    }
    
         [document appendString:@" var margin = { top: 20, right: 0, bottom: 10, left: 40 },\n"];
         [document appendString:@"width = document.width - margin.left - margin.right,\n"];
         [document appendString:@"height = document.height - margin.top - margin.bottom,\n"];
         [document appendString:@"gridSize = Math.floor(    Math.min( ((width  - margin.left - margin.right) / x_size ),   ((height) / y_size ))  ),\n"];
        [document appendString:@"legendElementWidth = gridSize + ((gridSize * 3) / 9),\n"];
        [document appendString:@"buckets = 5,\n"];
        [document appendString:@"colors = [\"#ffffd9\",\"#edf8b1\",\"#c7e9b4\",\"#7fcdbb\",\"#41b6c4\",\"#1d91c0\",\"#225ea8\",\"#253494\",\"#081d58\"];\n"];
        
        [document appendString:@"\nvar mdata=[\n"];
        
        for (int i = i_start_pos; i < [data count]; i++) {
            NSArray* row = [data objectAtIndex:i];
            for (int j = j_start_pos; j  < [row count]; j++) {
                [document appendFormat:@"{y: %d, x: %d, value: %@}", !useFirstColumnAndRowForLabels ? i + 1 : i, !useFirstColumnAndRowForLabels ? j + 1 : j, [row objectAtIndex:j]];
                if (   (i < ([data count] - 1)) ||   (j < ([row count] - 1))   ) {
                    [document appendString:@","];
                }
                [document appendString:@"\n"];
                
            
            }

        }
    
        [document appendString:@"\n];\n"];
        
        [document appendString:[self getSection:@"heatMapLayoutJS001"]];
     [document appendString:@"</script><div id=\"chart\"></div>"];    [document appendString:@"<script>x(1, mdata);\n</script></body></html>\n"];
    
    
    [self writeStringToStream:stream :document];

    
    
    [stream close];
    
}

@end
