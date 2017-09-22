//
//  HCCPGraphWriter.m
//  StreamGraph
//
//  Created by Ian Brown on 3/15/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPGraphWriter.h"

@implementation HCCPGraphWriter

-(void)writeStringToStream:(NSOutputStream*)stream :(NSString*)string  {
    NSData *strData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [stream write:(uint8_t *)[strData bytes] maxLength:[strData length]];
}

-(NSString*) getD3js {
    NSString* d3path = [[NSBundle mainBundle] pathForResource:@"d3"
                                                       ofType:@"txt"];
    return [NSString stringWithContentsOfFile:d3path
                                             encoding:NSUTF8StringEncoding
                                                error:NULL];
}


-(NSString*) getColorBrewerJs {
    NSString* jspath = [[NSBundle mainBundle] pathForResource:@"colorbrewer"
                                                       ofType:@"txt"];
    
    return [NSString stringWithContentsOfFile:jspath
                                     encoding:NSUTF8StringEncoding
                                        error:NULL];
}


-(NSString*) getSection:(NSString*)section {
    return NSLocalizedStringFromTable (section, @"d3resources", @"A comment");
}

-(NSString*) categoriesToJSArray:(NSArray*)data {
    
    NSMutableString* categories = [[NSMutableString alloc] init];
    [categories appendString:@"\nvar categories = ["];

    for (int i=1; i < [data count]; i++) { //I=1 so we skip first row
         NSArray* row = [data objectAtIndex:i];
        [categories appendString:@"\""];
        [categories appendString:[row objectAtIndex:0]];
        [categories appendString:@"\""];
        if (i < [data count] - 1) {
            [categories appendString:@","];
        }
        
    }
    [categories appendString:@"];\n"];
    return categories;
    
}


-(NSString*) xAxisToJSArray:(NSArray*)data :(NSArray*)columnOrder{
    NSMutableString* xAxis = [[NSMutableString alloc] init];
    [xAxis appendString:@"\nvar my_x_axis = ["];
    NSArray* headers = [data objectAtIndex:0];
    for (int j=1; j < [headers count]; j++) { //J=1 so we skip first column
        [xAxis appendString:@"\""];
         int mappedIndex = [[columnOrder objectAtIndex:j] intValue];
        [xAxis appendString:[[headers objectAtIndex:mappedIndex] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]  ];
        [xAxis appendString:@"\""];
        if (j < [headers count] - 1) {
            [xAxis appendString:@","];
        }
    }
    [xAxis appendString:@"];\n"];

    return xAxis;
    
}

-(int)getMaxPositionOfNonZeroData:(NSArray*)data :(NSArray*)columnOrder  {
    
    int farthestRecordedPosition = 0;
    
    
    // SKETCHY HACK STARTING AT 1ST (INSTEAD OF 0TH) INDEX TO SKIP HEADERS AND ROW LABELS
    for (int i = 1; i < [data count]; i++) {
        
        NSArray* record = [data objectAtIndex:i];
        NSLog(@"data row: %@", record);
        for (int j=1; j < [record count]; j++) {
            int mappedIndex = [[columnOrder objectAtIndex:j] intValue]; // get index from order column so graph matches column order in view
            if (!([@"" isEqualTo: [record objectAtIndex:mappedIndex]]  ||  ((int)[record objectAtIndex:mappedIndex]) ==  0 )) {
                if (farthestRecordedPosition < j) {
                    farthestRecordedPosition = j;
                }
            }
        }
    
    }
    
    return farthestRecordedPosition;
}


-(NSString*) dataToJSArray:(NSArray*)data :(NSArray*)columnOrder{
    
    
    NSMutableString* document = [[NSMutableString alloc] init];

    
    [document appendString:@"\ndata=[\n"];
    
    
    int limit = [self getMaxPositionOfNonZeroData:data :columnOrder];
    
    // SKETCHY HACK STARTING AT 1ST (INSTEAD OF 0TH) INDEX TO SKIP HEADERS AND ROW LABELS
    for (int i = 1; i < [data count]; i++) {
        [document appendString:@"[\n"];
        NSArray* record = [data objectAtIndex:i];
        NSLog(@"data row: %@", record);
        for (int j=1; j < limit + 1; j++) {
            int mappedIndex = [[columnOrder objectAtIndex:j] intValue]; // get index from order column so graph matches column order in view
            if ([@"" isEqualTo: [record objectAtIndex:mappedIndex]]) {
                [document appendString:@"0"];
            } else {
                [document appendString:[record objectAtIndex:mappedIndex]];
            }
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
   
    return document;
    

    
}

-(NSString*) colorsToJSArray:(NSArray*)colors {
    
    NSMutableString* document = [[NSMutableString alloc] init];

    
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
    return document;
    
}



@end
