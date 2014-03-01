//
//  HCCPStreamGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCPStreamGraphWriter : NSObject

-(void)writeToHtml:(NSArray*)data :(NSArray*)colors :(NSURL*)fileUrl :(NSString*)graphType;
-(NSArray*)interpolate:(NSArray*)data;

@end
