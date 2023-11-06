//
//  ContentView.swift
//  recipes
//
//  Created by Nathan Storm on 11/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCategory = "All"
    let recipeCategories = ["All", "Category1", "Category2", "Category3"]
    @State private var navigateToRecipeList = false

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select a category", selection: $selectedCategory) {
                    ForEach(recipeCategories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                Button(action: {
                    // Set navigateToRecipeList to true to trigger navigation
                    navigateToRecipeList = true
                }) {
                    Text("Show Recipes")
                }
            }
            .navigationTitle("Recipe Categories")
            .background(
                NavigationLink(destination: RecipeListView(selectedCategory: selectedCategory), isActive: $navigateToRecipeList) {
                    EmptyView()
                }
            )
        }
    }
}
