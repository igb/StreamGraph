//
//  TestCSVParser.m
//  StreamGraph
//
//  Created by Ian Brown on 4/23/16.
//  Copyright © 2016 Ian Brown. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HCCPCsvParser.h"

@interface TestCSVParser : XCTestCase

@end

@implementation TestCSVParser

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSimpleCsv {
    HCCPCsvParser* parser = [[HCCPCsvParser alloc] init];
    
    NSArray* result = [parser parse:@"a,b,c\n1,2,3"];
    
    
    XCTAssertNotNil(result);
    XCTAssertEqual(2, [result count]);
    
    NSArray* row0 = [result objectAtIndex:0];
    NSArray* row1 = [result objectAtIndex:1];

    XCTAssertEqual(3, [row0 count]);
    XCTAssertEqual(3, [row1 count]);
    
    NSArray* abc=[[NSArray alloc] initWithObjects:@"a",@"b",@"c",nil];
    NSArray* ott=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",nil];
    
    
    XCTAssertEqualObjects(abc, row0);
    XCTAssertEqualObjects(ott, row1);

    
    NSLog(@"result: %@", result);
}


- (void)testEscapedCommas {
    HCCPCsvParser* parser = [[HCCPCsvParser alloc] init];
    
    NSArray* result = [parser parse:@"a\\,,b,c\n1,2\\,,3"];
    
    
    XCTAssertNotNil(result);
    XCTAssertEqual(2, [result count]);
    
    NSArray* row0 = [result objectAtIndex:0];
    NSArray* row1 = [result objectAtIndex:1];
    
    XCTAssertEqual(3, [row0 count]);
    XCTAssertEqual(3, [row1 count]);
    
    NSArray* abc=[[NSArray alloc] initWithObjects:@"a,",@"b",@"c",nil];
    NSArray* ott=[[NSArray alloc] initWithObjects:@"1",@"2,",@"3",nil];
    
    
    XCTAssertEqualObjects(abc, row0);
    XCTAssertEqualObjects(ott, row1);
    
    
    NSLog(@"result: %@", result);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
