//
//  RecipeListView.swift
//  recipes
//
//  Created by Michael Carey on 11/5/23.
//

import SwiftUI

struct RecipeListView: View {
    let selectedCategory: String // Pass the selected category as a parameter
    
    @State private var randomMeals: [Meal] = [] // Store the fetched meals here
    @State private var isShowingDetails = false
    @State private var selectedMeal: Meal?

    var body: some View {
        NavigationStack {
            List(randomMeals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(meal: meal), isActive: $isShowingDetails) {
                    EmptyView()
                }
                .hidden() // Hidden link to trigger navigation programmatically
                
                Text(meal.strMeal)
                    .onTapGesture {
                        selectedMeal = meal
                        isShowingDetails.toggle()
                    }
            }
            .navigationTitle("Recipe List")
        }
        .onAppear {
            fetchRandomMeal()
        }
    }
    
    private func fetchRandomMeal() {
        APIManager.fetchRandomMeal { result in
            switch result {
            case .success(let meals):
                randomMeals = meals
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct MealDetailView: View {
    let meal: Meal
    
    var body: some View {
        VStack {
            Text("Meal: \(meal.strMeal)")
            Text("Category: \(meal.strCategory)")
            Text("Area: \(meal.strArea)")
            // Add more details as needed
        }
        .navigationTitle("Meal Details")
    }
}

