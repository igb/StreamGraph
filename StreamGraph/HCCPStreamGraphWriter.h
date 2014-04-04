//
//  HCCPStreamGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCCPGraphWriter.h"


@interface HCCPStreamGraphWriter : HCCPGraphWriter

-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(BOOL)drawGrid;

@end
