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

-(NSString*) getSection:(NSString*)section {
    return NSLocalizedStringFromTable (section, @"d3resources", @"A comment");
}


-(NSString*) dataToJSArray:(NSArray*)data {
    NSMutableString* document = [[NSMutableString alloc] init];

    
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
