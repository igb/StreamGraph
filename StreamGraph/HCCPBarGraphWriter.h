//
//  HCCPBarGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 3/15/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCCPGraphWriter.h"


@interface HCCPBarGraphWriter : HCCPGraphWriter

-(void)writeToHtml:(NSArray*)data :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType :(NSString*)graphBackground :(long)barGap;
@end
