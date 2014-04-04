//
//  HCCPStreamGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPStreamGraphWriter.h"

@implementation HCCPStreamGraphWriter



-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(BOOL)drawGrid {
    
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


    
    [document appendString:[self dataToJSArray:data:columnOrder]];
    [document appendString:[self colorsToJSArray:colors]];

    if (drawGrid) {
       [document appendString:@"\nfunction make_x_axis() {return d3.svg.axis().scale(x).orient(\"bottom\").ticks(48)};\nfunction make_y_axis() { return d3.svg.axis().scale(y).orient(\"left\").ticks(25)};\n"];
    }
    

    [document appendString:@"var n ="];
    [document appendString:[NSString stringWithFormat:@"%li", [data count] -1]]; // number of layers
    [document appendString:@",\nm = "];
    [document appendString:[NSString stringWithFormat:@"%li",[[data objectAtIndex:0] count] -1]]; // number of samples per layer
	[document appendString:@",\n"];
    
    [document appendString:@"stack = d3.layout.stack().offset(\""],
    
    [document appendString:graphType];
    
    [document appendString:@"\"),"];

    
    [document appendString:[self getSection:@"section1"]];
     
   
    
    [document appendString:[self getSection:@"section2"]];
    
    if (drawGrid) {
        [document appendString:@"\nsvg.append(\"g\").attr(\"class\", \"grid\").attr(\"transform\", \"translate(0,\" + height + \")\").call(make_x_axis().tickSize(-height, 0, 0).tickFormat(\"\"))"];
        [document appendString:@"\nsvg.append(\"g\").attr(\"class\", \"grid\").call(make_y_axis().tickSize(-width, 0, 0).tickFormat(\"\"))"];
    }
    
    [document appendString:[self getSection:@"section3"]];

    
    [self writeStringToStream:stream :document];

    [stream close];
   
}


@end
