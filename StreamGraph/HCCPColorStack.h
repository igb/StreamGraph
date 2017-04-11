//
//  HCCPColorStack.h
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface HCCPColorStack : NSObject {
    NSMutableArray *colors;
    int head;
}
- (NSString*)colorToHexString:(NSColor*)color;
- (void)add:(NSColor*)color;
- (id)pop;
@end
