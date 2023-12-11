//
//  recipesTests.swift
//  recipesTests
//
//  Created by Nathan Storm on 11/5/23.
//

import XCTest
@testable import recipes

class APIManagerTests: XCTestCase {

    // MARK: - Test Case for fetching meal categories
    
    func testFetchMealCategories() {
        let expectation = self.expectation(description: "Fetch meal categories")
        
        APIManager.fetchMealCatagories { result in
            switch result {
            case .success(let categories):
                XCTAssertFalse(categories.isEmpty, "Categories should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch meal categories with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: - Test Case for fetching category meals
    
    func testFetchCategoryMeals() {
        let expectation = self.expectation(description: "Fetch category meals")
        
        let categoryType = "Seafood" // Provide a valid category type for testing
        
        APIManager.fetchCatagoryMeals(categoryType: categoryType) { result in
            switch result {
            case .success(let categoryMeals):
                XCTAssertFalse(categoryMeals.isEmpty, "Category meals should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch category meals with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: - Test Case for fetching meal details
    
    func testFetchMealDetails() {
        let expectation = self.expectation(description: "Fetch meal details")
        
        let mealId = "52842" // Provide a valid meal ID for testing
        
        APIManager.fetchMealDetails(id: mealId) { result in
            switch result {
            case .success(let meals):
                XCTAssertFalse(meals.isEmpty, "Meal details should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch meal details with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

