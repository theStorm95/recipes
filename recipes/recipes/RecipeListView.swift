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
                        HStack {
                            // Display the image using URLImage
                            AsyncImage(url: URL(string: meal.strMealThumb)) { image in image.resizable() } placeholder: { Color.red }
                                .frame(width: 128, height: 128)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                            Text(meal.strMeal)
                        }
                    }
                }
                .navigationTitle("Recipe List")
                .navigationBarItems(trailing: cartButton)
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
    
    var cartButton: some View {
        NavigationLink(destination: ShoppingCartView()) {
            Image(systemName: "cart")
        }
    }
}

