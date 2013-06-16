//
//  HCCPColorStack.m
//  StreamGraph
//
//  Created by Ian Brown on 6/16/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "HCCPColorStack.h"

@implementation HCCPColorStack


- (id) init {
    self = [super init];
    if (self != nil) {
        colors = [[NSMutableArray alloc] init];
        head = 0;
    }
    return self;
}

- (void)add:(NSColor*)color {
    @synchronized(self) {
        [colors addObject: color];
    }
}

- (id)pop {
     @synchronized(self) {
         NSColor* color = [colors objectAtIndex:head];
         if (head==[colors count] - 1) {
             head=0;
         } else {
             head=head+1;
         }
         return color;
     }
}

@end
