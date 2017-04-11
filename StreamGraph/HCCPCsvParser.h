//
//  HCCPCsvParser.h
//  StreamGraph
//
//  Created by Ian Brown on 1/18/16.
//  Copyright © 2016 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface HCCPCsvParser : NSObject

-(NSArray*)parse:(NSString*)line;


@end
