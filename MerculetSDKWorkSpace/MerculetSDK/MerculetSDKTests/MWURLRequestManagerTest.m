//
//  MWURLRequestManagerTest.m
//  MerculetSDKTests
//
//  Created by 王大吉 on 23/5/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWURLRequestManager.h"

@interface MWURLRequestManagerTest : XCTestCase

@property(nonatomic, strong) NSHTTPURLResponse *response;

@end

@implementation MWURLRequestManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testSetStartURLRequestManagerRequest {
    
    
    
    // Given
    MWURLRequestManager *manager = [[MWURLRequestManager alloc] init];
    NSString *urlString = @"https://httpbin.org/get";/// get请求

    XCTestExpectation *expextation = [self expectationWithDescription:urlString];
    
    // When
    [manager GET:urlString
         headers:nil
         success:^(NSURLResponse *response, id responseObject, NSData *data) {
        self.response = (NSHTTPURLResponse *)response;
        [expextation fulfill];
             
    } failure:^(NSURLResponse *response, NSError *error) {
        self.response = (NSHTTPURLResponse *)response;
        [expextation fulfill];
        
    }];

    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        // 等待30秒，若该测试未结束（未收到 fulfill方法）则测试结果为失败
     
    }];
    
    // Then
//    XCTAssertNotNil(response, "response should not be nil");
    XCTAssertTrue(self.response.statusCode == 200, "response status code should be 200");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
