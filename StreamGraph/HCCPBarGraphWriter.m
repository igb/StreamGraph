//
//  HCCPBarGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 3/15/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPBarGraphWriter.h"

@implementation HCCPBarGraphWriter

-(void)writeToHtml:(NSArray*)data :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(long)barGap{
    
    
    NSOutputStream *stream = [[NSOutputStream alloc]  initWithURL:fileUrl append:NO];
    [stream open];
    
    
    
    NSMutableString* document = [[NSMutableString alloc] init];
    
    
    
    
    [self writeStringToStream:stream :[self getSection:@"header"]];
    [self writeStringToStream:stream :@"<svg class=\"chart\"></svg>"];

    [self writeStringToStream:stream :@"<script>"];
    [self writeStringToStream:stream :[self getD3js]];
    [self writeStringToStream:stream :@"</script>"];
    [self writeStringToStream:stream :[self getSection:@"section0"]];
    [self writeStringToStream:stream :graphBackground];
    [self writeStringToStream:stream :[self getSection:@"section01"]];
    
    
    
    [document appendString:[self dataToJSArray:data]];
    [document appendString:[self colorsToJSArray:colors]];
    [document appendString:[self xAxisToJSArray:data]];
    [document appendString:[self categoriesToJSArray:data]];
    
    [document appendString:@"\nvar color = d3.scale.ordinal().range(colors);\n"];
    [document appendString:@"\ncolor.domain(categories);\n"];

    
    ///
   
    
    
    
    [self writeStringToStream:stream :document];
    
     [self writeStringToStream:stream :[self getSection:@"barGraphDataTransformationJS"]];
    
    [self writeStringToStream:stream :[self getSection:@"barGraphLayoutJS001"]];

    // xaxes
     [self writeStringToStream:stream :[self generateXAxis:barGap]];
    
    [self writeStringToStream:stream :[self getSection:@"barGraphLayoutJS002"]];

    [self writeStringToStream:stream :@"\n</script>\n</body>\n</html>"];
    [stream close];
    
    
}

-(NSString*) generateXAxis:(long)spacingPercentage {
    NSString* function=@"= d3.scale.ordinal().domain(my_x_axis).rangeBands([0, width],0.";

    NSMutableString* xAxis = [[NSMutableString alloc] init];
    [xAxis appendString:@"var x"];
    [xAxis appendString:function];
    [xAxis appendFormat:@"%ld", spacingPercentage];
    [xAxis appendString:@");\n\n"];
	
    [xAxis appendString:@"var z"];
    [xAxis appendString:function];
    [xAxis appendFormat:@"%ld", spacingPercentage];
    [xAxis appendString:@");\n\n"];
    
    return xAxis;
    
	
}



@end
