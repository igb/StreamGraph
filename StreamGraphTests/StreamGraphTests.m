//
//  StreamGraphTests.m
//  StreamGraphTests
//
//  Created by Ian Brown on 6/14/13.
//  Copyright (c) 2013 Ian Brown. All rights reserved.
//

#import "StreamGraphTests.h"
#import "HCCPColorStack.h"



@implementation StreamGraphTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testColorStackLoopBeyondBounds {
    
    HCCPColorStack* colorStack = [[HCCPColorStack alloc] init];
    
    
    //pinks
    [colorStack add:[NSColor colorWithCalibratedRed:(255/255.0f) green:(247/255.0f) blue:(243/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(254/255.0f) green:(235/255.0f) blue:(226/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(253/255.0f) green:(224/255.0f) blue:(221/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(252/255.0f) green:(197/255.0f) blue:(192/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(251/255.0f) green:(180/255.0f) blue:(185/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(250/255.0f) green:(159/255.0f) blue:(181/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(247/255.0f) green:(104/255.0f) blue:(161/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(221/255.0f) green:(52/255.0f) blue:(151/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(174/255.0f) green:(1/255.0f) blue:(126/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(122/255.0f) green:(1/255.0f) blue:(119/255.0f) alpha:1.0]];
    [colorStack add:[NSColor colorWithCalibratedRed:(73/255.0f) green:(0/255.0f) blue:(106/255.0f) alpha:1.0]];
    
    
    for (int i=0; i < 222; i++) {
        NSColor* c = [colorStack pop];
        NSLog(@"%@", [colorStack colorToHexString:c]);
        
    }
    
}

@end
