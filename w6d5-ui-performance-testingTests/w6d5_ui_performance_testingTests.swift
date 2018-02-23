//
//  w6d5_ui_performance_testingTests.swift
//  w6d5-ui-performance-testingTests
//
//  Created by Ryan Maksymic on 2018-02-23.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest
@testable import w6d5_ui_performance_testing

class w6d5_ui_performance_testingTests: XCTestCase
{
  override func setUp()
  {
    super.setUp()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  func testPerformanceExample()
  {
    self.measure {
      PerformanceDataModel.doSomething()
    }
  }
}
