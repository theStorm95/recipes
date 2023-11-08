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

    var body: some View {
        // Display the list of recipes for the selected category
        // You can filter your recipe data based on the category here.

        Button(action: {
            APIManager.fetchRandomMeal { result in
                switch result {
                case .success(let meals):
                    randomMeals = meals
                    print(meals)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }) {
            Text("Fetch Random Meal")
        }
    }
}
