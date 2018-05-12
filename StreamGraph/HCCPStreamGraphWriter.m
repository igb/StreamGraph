//
//  HCCPStreamGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPStreamGraphWriter.h"

@implementation HCCPStreamGraphWriter



-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(BOOL)drawGrid :(int)xTicks :(int)yTicks :(NSString*)gridColor :(float)brightness :(BOOL)drawLegend{
    
    NSOutputStream *stream = [[NSOutputStream alloc]  initWithURL:fileUrl append:NO];
    [stream open];
    
    
    
    NSMutableString* document = [[NSMutableString alloc] init];
    
    
    
    
    [self writeStringToStream:stream :[self getSection:@"header"]];
    [self writeStringToStream:stream :@"<script>"];
    [self writeStringToStream:stream :[self getD3js]];
    [self writeStringToStream:stream :@"</script>"];
    
    if (drawLegend)  {
        [self writeStringToStream:stream :@"\n\n\n<!-- D3 Legend -->\n\n\n"];
        
        //CSS
        [self writeStringToStream:stream :@"\n<style type=\"text/css\">\n"];
        [self writeStringToStream:stream :@"\n.legendLinear {\n"];
        [self writeStringToStream:stream :@"\nfont-size:8pt;\n"];
        [self writeStringToStream:stream :@"\n}\n"];
        [self writeStringToStream:stream :@"\n</style>\n"];

        //D3 LEGEND JS
        [self writeStringToStream:stream :@"\n<script>\n"];
        [self writeStringToStream:stream :[self getD3Legendjs]];
        [self writeStringToStream:stream :@"</script>\n\n\n"];

    }
    

    [self writeStringToStream:stream :@"\n<style>.grid .tick {\nstroke: #"];
    [self writeStringToStream:stream :gridColor];
    [self writeStringToStream:stream :@";\nopacity: 0.3;\n}\n</style>\n"];
    [self writeStringToStream:stream :[self getSection:@"section0"]];
    [self writeStringToStream:stream :graphBackground];
    [self writeStringToStream:stream :[self getSection:@"section01"]];


    
    [document appendString:[self dataToJSArray:data:columnOrder]];
    [document appendString:[self colorsToJSArray:colors]];

    if (drawGrid) {
       [document appendString:[NSString stringWithFormat:@"\nfunction make_x_axis() {return d3.svg.axis().scale(x).orient(\"bottom\").ticks(%ld)};\nfunction make_y_axis() { return d3.svg.axis().scale(y).orient(\"left\").ticks(%ld)};\n", (long)xTicks, (long)yTicks]];
    }
    
    int limit = [super getMaxPositionOfNonZeroData:data :columnOrder];

    [document appendString:@"var n ="];
    [document appendString:[NSString stringWithFormat:@"%li", (long)limit]]; // number of layers
    [document appendString:@",\nm = "];
    [document appendString:[NSString stringWithFormat:@"%li", (long)limit]]; // number of samples per layer
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
    
    [document appendString:[NSString stringWithFormat:@"\nvar brR=%f;\n", brightness]];
    [document appendString:[NSString stringWithFormat:@"var brG=%f;\n", brightness]];
    [document appendString:[NSString stringWithFormat:@"var brB=%f;\n", brightness]];

    if (brightness != 1.0f) {
        [document appendString:[self getSection:@"filters"]];

    }
    
    if(drawLegend) {
        
        
        
        
        NSMutableString* legendNames = [[NSMutableString alloc] init];
        [legendNames appendString:@"names = ["];

        int i;
        for (i = 1; i < [data count]; i++) {
            id myRow = [data objectAtIndex:i];
            [legendNames appendString:[NSString stringWithFormat:@"\"%@\"", myRow[0]]];
            if (i < [data count] - 1) {
                [legendNames appendString:@","];
            }
        }
        
          [legendNames appendString:@"];\n"];
        
        [document appendString:legendNames];
        
        [document appendString:@"var ordinal = d3.scale.ordinal().domain(names.reverse()).range(colors.reverse());\n"];
        
        [document appendString:@"svg.append(\"g\").attr(\"class\", \"legendLinear\").attr(\"transform\", \"translate(\" + (width - 100) + \", 10)\");\n"];
        [document appendString:@"var legendLinear = d3.legend.color().shapeWidth(10).shapeHeight(10).useClass(\"legend\").orient('vertical').scale(ordinal).shapePadding(3);\n"];
        [document appendString:@"svg.select(\".legendLinear\").call(legendLinear);\n"];
    }
    
    
    [document appendString:[self getSection:@"section3"]];

    
    [self writeStringToStream:stream :document];

    [stream close];
   
}


@end
