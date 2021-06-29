//
//  HCCPPieGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 11/2/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPGraphWriter.h"

@interface HCCPPieGraphWriter : HCCPGraphWriter

-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(BOOL)switchColumnsAndRows :(BOOL)labelSlices;


@end
