//
//  MealDetailView.swift
//  recipes
//
//  Created by Michael Carey on 11/30/23.
//

import Foundation

import SwiftUI

struct RecipeListView: View {
    let selectedCategory: String // Pass the selected category as a parameter
    
    @State private var isShowingDetails = false
    @State private var categoryMeals: [CatagoryMeals] = []

    var body: some View {
            NavigationStack {
                List(categoryMeals, id: \.idMeal) { meal in
                    NavigationLink(destination: MealDetailView(id: meal.idMeal)) {
                        Text(meal.strMeal)
                    }
                }
                .navigationTitle("Recipe List")
            }
            .onAppear {
                fetchCategoryMeals()
            }
        }
    
    private func fetchCategoryMeals() {
        APIManager.fetchCatagoryMeals(categoryType: selectedCategory) { result in
            switch result {
            case .success(let response):
                categoryMeals = response
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct MealDetailView: View {
    @State private var mealToDisplay: [Meal] = [] // Use @State to store the fetched meal details
    let id: String // Use the type of your meal item from the list
    
    var body: some View {
        VStack {
            // Display meal details using mealToDisplay
            if !mealToDisplay.isEmpty {
                Text("Meal: \(mealToDisplay[0].strMeal)")
                Text("Category: \(mealToDisplay[0].strCategory)")
                Text("Area: \(mealToDisplay[0].strArea)")
                // Add more details as needed
            } else {
                Text("Loading...") // Show loading message while fetching meal details
            }
        }
        .navigationTitle("Meal Details")
        .onAppear {
            fetchMeal(id: id)
        }
    }
    
    private func fetchMeal(id: String) {
        APIManager.fetchMealDetails(id: id) { result in
            switch result {
            case .success(let meals):
                mealToDisplay = meals
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

