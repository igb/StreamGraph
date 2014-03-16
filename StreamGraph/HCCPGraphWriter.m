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
    
}




@end
