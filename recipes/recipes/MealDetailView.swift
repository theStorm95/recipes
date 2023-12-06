//
//  MealDetailView.swift
//  recipes
//
//  Created by Michael Carey on 12/3/23.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    let id: String // Use the type of your meal item from the list
    @State private var mealToDisplay: [Meal] = [] // Use @State to store the fetched meal details
    @EnvironmentObject var cartManager: ShoppingCartManager  // Create an instance of the manager
    @State private var isAddingToCart = false
    @State private var selectedIngredient = ""
    
    var body: some View {
        VStack {
            // Display meal details using mealToDisplay
            if !mealToDisplay.isEmpty {
                List{
                    Text("Basic Details")
                        .font(.headline)
                    Text("Meal: \(mealToDisplay[0].strMeal)")
                    Text("Category: \(mealToDisplay[0].strCategory)")
                    Text("Region: \(mealToDisplay[0].strArea)")
                    Section {
                        // Display ingredients and measures
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ingredients:")
                                .font(.headline)
                            
                            ForEach(mealToDisplay[0].ingredientMeasureArray, id: \.self) { ingredientMeasure in
                                HStack {
                                    Text(ingredientMeasure)
                                    Spacer()
                                    Button(action: {
                                        selectedIngredient = ingredientMeasure
                                        isAddingToCart.toggle()
                                    }) {
                                        Image(systemName: "cart.badge.plus")
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                    }
                    
                    Text("Instructions: \(mealToDisplay[0].strInstructions)")
                }
            } else {
                Text("Loading...") // Show loading message while fetching meal details
            }
        }
        .navigationTitle("Meal Details")
        .navigationBarItems(trailing: cartButton)
        .onAppear {
            fetchMeal(id: id)
        }
        .sheet(isPresented: $isAddingToCart) {
            AddToCartSheet(ingredient: $selectedIngredient, isPresented: $isAddingToCart, shoppingCart: $cartManager.shoppingCart)
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
    
    var cartButton: some View {
        NavigationLink(destination: ShoppingCartView(shoppingCart: $cartManager.shoppingCart)) {
            Image(systemName: "cart")
        }
    }
}
