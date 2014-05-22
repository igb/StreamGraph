//
//  HCCPHeatMapGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 4/26/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import "HCCPGraphWriter.h"

@interface HCCPHeatMapGraphWriter : HCCPGraphWriter

-(void)writeToHtml:(NSArray*)data :(NSArray*)columnOrder :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(BOOL)constrainCells :(BOOL)displayLabels :(BOOL)useFirstColumnAndRowForLabels :(BOOL)displayLegend :(long)buckets :(NSString*)palette :(BOOL)reverseColorOrder;

@end
