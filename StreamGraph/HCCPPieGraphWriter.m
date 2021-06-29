//
//  HCCPPieGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 11/2/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPPieGraphWriter.h"

@implementation HCCPPieGraphWriter



-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(BOOL)switchColumnsAndRows :(BOOL)labelSlices{
    
    
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
    
    
    
    [document appendString:[self dataToJSArray:data:columnOrder]];
    [document appendString:[self colorsToJSArray:colors]];
    [document appendString:[self xAxisToJSArray:data:columnOrder]];
    [document appendString:[self categoriesToJSArray:data]];
    
    [document appendString:@"\nvar color = d3.scale.ordinal().range(colors);\n"];
    [document appendString:@"\ncolor.domain(categories);\n"];
    
    
    ///
    
    [self writeStringToStream:stream :[self getSection:@"pieChart001"]];
    
    
    [self writeStringToStream:stream :document];
    
    [self writeStringToStream:stream :[self getSection:@"pieChart002"]];
    
    
    if (labelSlices) {
        [self writeStringToStream:stream :[self getSection:@"pieChart003"]];
    }
    
    [self writeStringToStream:stream :@"\n</script>\n</body>\n</html>"];
    [stream close];
    
    
    
    
}

@end
