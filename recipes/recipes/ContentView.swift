//
//  ContentView.swift
//  recipes
//
//  Created by Nathan Storm on 11/5/23.
//

import Foundation
import SwiftUI

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex

        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


struct ContentView: View {
    @State private var selectedCategory = "All"
    let recipeCategories = ["All", "Category1", "Category2", "Category3"]
    @State private var navigateToRecipeList = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Recipe Generator").font(.largeTitle).bold()
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
            //.navigationTitle("Recipe Categories")
            .background(
                NavigationLink(destination: RecipeListView(selectedCategory: selectedCategory), isActive: $navigateToRecipeList) {
                    EmptyView()
                }
            )
        }
    }
}
