//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Ryan Maksymic on 2018-02-23.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase
{
  var app : XCUIElement!
  
  override func setUp()
  {
    super.setUp()
    
    continueAfterFailure = false
    
    XCUIApplication().launch()
    
    app = XCUIApplication()
  }
  
  override func tearDown()
  {
    super.tearDown()
    
    deleteAllMeals()
  }
  
  func test_addNewMeal()
  {
    addNewMeal(mealName: "Burger", numberOfCalories: 300)
  }
  
  func addNewMeal(mealName: String, numberOfCalories: Int)
  {
    app.navigationBars["Master"].buttons["Add"].tap()
    
    let addAMealAlert = app.alerts["Add a Meal"]
    let collectionViewsQuery = addAMealAlert.collectionViews
    collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
    
    let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    textField.tap()
    textField.tap()
    textField.typeText("\(numberOfCalories)")
    addAMealAlert.buttons["Ok"].tap()
  }
  
  func test_deleteMeal()
  {
    deleteMeal(mealName: "Burger", numberOfCalories: 300)
  }
  
  func deleteMeal(mealName: String, numberOfCalories: Int)
  {
    let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
    
    if staticText.exists
    {
      staticText.swipeLeft()
      app.tables.buttons["Delete"].tap()
    }
  }
  
  func test_ShowMealDetail()
  {
    showMealDetail(mealName: "Burger", numberOfCalories: 300)
    
    let detailLabelText = app/*@START_MENU_TOKEN@*/.staticTexts["detailViewControllerLabel"]/*[[".staticTexts[\"Burger - 300\"]",".staticTexts[\"detailViewControllerLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label
    
    XCTAssertEqual(detailLabelText, "Burger - 300")
    
    app.navigationBars["Detail"].buttons["Master"].tap()
  }
  
  func showMealDetail(mealName: String, numberOfCalories: Int)
  {
    XCUIApplication().tables.staticTexts["\(mealName) - \(numberOfCalories)"].tap()
  }
  
  func test_deleteAllMeals()
  {
    deleteAllMeals()
  }
  
  func deleteAllMeals()
  {
    let table = app.tables.element(boundBy: 0)
    
    while table.cells.count > 0
    {
      let topCell = table.cells.element(boundBy: 0)
      topCell.swipeLeft()
      
      let deleteButton = table.buttons["Delete"]
      deleteButton.tap()
    }
  }
  
  func test_performance_addAndDeleteMeal()
  {
    measure {
      addNewMeal(mealName: "Burger", numberOfCalories: 300)
      deleteMeal(mealName: "Burger", numberOfCalories: 300)
    }
  }
}
