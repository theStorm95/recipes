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
    @State private var selectedCategory: String = "Beef"
    @State private var recipeCategories: [Catagory] = []
    @State private var navigateToRecipeList = false
    
    

    var body: some View {
        NavigationStack {
                        VStack {
                            Text("Recipe Generator").font(.largeTitle).bold()
                            List {
                                Text("Choose Category")
                                ForEach(recipeCategories, id: \.idCategory) { category in
                                    VStack(alignment: .leading) {
                                        NavigationLink(category.strCategory, destination: RecipeListView(selectedCategory: category.strCategory))
                                    }
                                    .padding(10)
                                    .background(
                                                                AsyncImage(url: URL(string: category.strCategoryThumb)) { phase in
                                                                    switch phase {
                                                                    case .empty:
                                                                        // Placeholder view while loading
                                                                        Color.gray
                                                                    case .success(let image):
                                                                        // Successfully loaded image
                                                                        image
                                                                            .resizable()
                                                                            .scaledToFill()
                                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                                            .clipped()
                                                                    case .failure(_):
                                                                        // Placeholder view on failure
                                                                        Color.gray
                                                                    @unknown default:
                                                                        // Placeholder view on unknown state
                                                                        Color.gray
                                                                    }
                                                                }
                                                            )
                                }
                                .padding()
                            }
                        }
                        .onAppear {
                            fetchMealCategories()
                        }
                        .navigationBarItems(trailing: cartButton)
                }
    }
                               
    private func fetchMealCategories() {
        APIManager.fetchMealCatagories { result in
            switch result {
                case .success(let categories):
                    recipeCategories = categories
                case .failure(let error):
                    print("Error fetching meal categories:", error)
            }
        }
    }
    
    var cartButton: some View {
        NavigationLink(destination: ShoppingCartView()) {
            Image(systemName: "cart")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
