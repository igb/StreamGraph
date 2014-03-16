//
//  HCCPStreamGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPStreamGraphWriter.h"

@implementation HCCPStreamGraphWriter



-(void)writeToHtml:(NSArray*)data :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground {
    
    NSOutputStream *stream = [[NSOutputStream alloc]  initWithURL:fileUrl append:NO];
    [stream open];
    
    
    
    NSMutableString* document = [[NSMutableString alloc] init];
    
    
    
    
    [self writeStringToStream:stream :[self getSection:@"header"]];
    [self writeStringToStream:stream :@"<script>"];
    [self writeStringToStream:stream :[self getD3js]];
    [self writeStringToStream:stream :@"</script>"];
    [self writeStringToStream:stream :[self getSection:@"section0"]];
    [self writeStringToStream:stream :graphBackground];
    [self writeStringToStream:stream :[self getSection:@"section01"]];


    [document appendString:@"\ndata=[\n"];
    
    // SKETCHY HACK STARTING AT 1ST (INSTEAD OF 0TH) INDEX TO SKIP HEADERS AND ROW LABELS
    for (int i = 1; i < [data count]; i++) {
        [document appendString:@"[\n"];
        NSArray* record = [data objectAtIndex:i];
        for (int j=1; j < [record count]; j++) {
            [document appendString:[record objectAtIndex:j]];
            if (j < [record count] - 1) {
                [document appendString:@","];
            }
        }
        [document appendString:@"\n]"];
        if (i < [data count] - 1) {
             [document appendString:@","];
        }
        
    }
    [document appendString:@"\n];\n\n"];

    
    
    [document appendString:@"var n ="];
    [document appendString:[NSString stringWithFormat:@"%li", [data count] -1]]; // number of layers
    [document appendString:@",\nm = "];
    [document appendString:[NSString stringWithFormat:@"%li",[[data objectAtIndex:0] count] -1]]; // number of samples per layer
	[document appendString:@",\n"];
    
    [document appendString:@"stack = d3.layout.stack().offset(\""],
    
    [document appendString:graphType];
    
    [document appendString:@"\"),"];

    
    [document appendString:NSLocalizedStringFromTable (@"section1", @"d3resources", @"A comment")];
    [document appendString:@"var colors = ["];
    for (int i = 1; i < [colors count]; i++) { //starting at "1" because of the headers (need to fix)
        NSColor* color = [colors objectAtIndex:i];
         NSString* hexString = [NSString stringWithFormat:@"%02X%02X%02X",
                               (int) (color.redComponent * 0xFF), (int) (color.greenComponent * 0xFF),
                               (int) (color.blueComponent * 0xFF)];
        [document appendString:[NSString stringWithFormat:@"\"%@\"", hexString]];
        if (i < [colors count] - 1) {
            [document appendString:@","];
        }
    }
    
    [document appendString:@"];\n"];

    NSString* section2 = NSLocalizedStringFromTable (@"section2", @"d3resources", @"A comment");

    [document appendString:section2];
    [self writeStringToStream:stream :document];

    [stream close];
   
}


@end
