//
//  HCCPGraphWriter.h
//  StreamGraph
//
//  Created by Ian Brown on 3/15/14.
//  Copyright (c) 2014 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCPGraphWriter : NSObject

-(void)writeStringToStream:(NSOutputStream*)stream :(NSString*)string;
-(NSString*) getD3js;
-(NSString*) getSection:(NSString*)section;
-(NSString*) dataToJSArray:(NSArray*)data;



@end
