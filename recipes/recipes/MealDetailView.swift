//
//  MealDetailView.swift
//  recipes
//
//  Created by Michael Carey on 12/3/23.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    @State private var mealToDisplay: [Meal] = [] // Use @State to store the fetched meal details
    let id: String // Use the type of your meal item from the list
    
    var body: some View {
        VStack {
            // Display meal details using mealToDisplay
            if !mealToDisplay.isEmpty {
                List{
                    Text("Meal: \(mealToDisplay[0].strMeal)")
                    Text("Category: \(mealToDisplay[0].strCategory)")
                    Text("Area: \(mealToDisplay[0].strArea)")
                    
                    // Display ingredients and measures
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients:")
                            .font(.headline)
                        
                        ForEach(mealToDisplay[0].ingredientMeasureArray, id: \.self) { ingredientMeasure in
                            Text(ingredientMeasure)
                        }
                    }
                    
                    Text("Instructions: \(mealToDisplay[0].strInstructions)")
                }
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
