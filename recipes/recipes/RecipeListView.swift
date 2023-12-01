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
    
    @State private var mealToDisplay: [Meal] = [] // Store the fetched meals here
    @State private var isShowingDetails = false
    @State private var categoryMeals: [CatagoryMeals] = []

    var body: some View {
        NavigationStack {
            List(categoryMeals, id: \.idMeal) { meal in
                NavigationLink {
                    MealDetailView(meal: mealToDisplay)
                }
                label: {
                    Text(meal.strMeal)
                        .onTapGesture {
                            fetchMeal(id: meal.idMeal)
                        }
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

struct MealDetailView: View {
    let meal: [Meal]
    
    var body: some View {
        VStack {
            Text("Meal: \(meal[0].strMeal)")
            Text("Category: \(meal[0].strCategory)")
            Text("Area: \(meal[0].strArea)")
            // Add more details as needed
        }
        .navigationTitle("Meal Details")
    }
}

