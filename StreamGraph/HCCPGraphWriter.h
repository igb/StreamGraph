//
//  HCCPGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 3/15/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface HCCPGraphWriter : NSObject

-(void)writeStringToStream:(NSOutputStream*)stream :(NSString*)string;
-(NSString*) getD3js;
-(NSString*) getColorBrewerJs;
-(NSString*) getSection:(NSString*)section;
-(NSString*) dataToJSArray:(NSArray*)data :(NSArray*)columnOrder;
-(NSString*) xAxisToJSArray:(NSArray*)data :(NSArray*)columnOrder;
-(NSString*) colorsToJSArray:(NSArray*)colors;
-(NSString*) categoriesToJSArray:(NSArray*)data;
-(int)getMaxPositionOfNonZeroData:(NSArray*)data :(NSArray*)columnOrder;




@end
