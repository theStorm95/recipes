//
//  RecipeListView.swift
//  recipes
//
//  Created by Michael Carey on 11/5/23.
//

import SwiftUI

struct RecipeListView: View {
    let selectedCategory: String // Pass the selected category as a parameter

    var body: some View {
        // Display the list of recipes for the selected category
        // You can filter your recipe data based on the category here.
        Text("Recipes for \(selectedCategory)")
    }
}
