//
//  HCCPColorStack.h
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCPColorStack : NSObject {
    NSMutableArray *colors;
    int head;
}
- (void)add:(NSColor*)color;
- (id)pop;
@end
