//
//  HCCPCsvParser.m
//  StreamGraph
//
//  Created by Ian Brown on 1/18/16.
//  Copyright © 2016 Ian Brown. All rights reserved.
//


#import "HCCPCsvParser.h"


@implementation HCCPCsvParser

-(NSArray*)parse:(NSString*)data {
    NSMutableArray* table = [[NSMutableArray alloc] init];
    
    NSArray* rows = [data componentsSeparatedByString: @"\n"];
    
    for(int i = 0; i < [rows count]; i++) {
        [table addObject:[self parseLine:[rows objectAtIndex:i]]];
    }
    return table;
}

-(NSArray*)parseLine:(NSString*)line {
    
    
    NSMutableArray* row = [[NSMutableArray alloc] init];
    
    NSUInteger len = [line length];
    unichar buffer[len+1];
    
    [line getCharacters:buffer range:NSMakeRange(0, len)];
    
    NSLog(@"getCharacters:range: with unichar buffer");
    
    bool is_data = false;
    bool is_escape = false;
    
    NSMutableString* element = [[NSMutableString alloc] init];

    
    for(int i = 0; i < len; i++) {
        NSLog(@"%C", buffer[i]);
        if (buffer[i] == ',' && !is_escape) {
            [row addObject:element];
            element = [[NSMutableString alloc] init];
            continue;
        } if (buffer[i] == '\\' && !is_escape) {
            is_escape = true;
            continue;
        }
        
        [element appendString:  [NSString stringWithCharacters:&buffer[i] length:1] ];
        if (is_escape) {
            is_escape = false;
        }
    }
    
    [row addObject:element];
    
    return row;
    
        
}

@end
