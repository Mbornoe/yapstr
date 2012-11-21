//
//  yapstOCUnit.m
//  yapstOCUnit
//
//  Created by Jonas Markussen on 21/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "yapstOCUnit.h"
#import "NetworkDriver.h"

@implementation yapstOCUnit

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

- (void)testExample
{
    NSArray *events = [NetworkDriver regEvents];
    STAssertNotNil(events, @"regEvents creation should fail");
}

@end
