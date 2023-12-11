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
    
    init() {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.backgroundColor = UIColor.systemGray6
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }

    var body: some View {
        NavigationStack {
            ScrollView {
            VStack {
                Text("Recipe Generator")
                    .font(.largeTitle)
                    .bold()
                    .padding(20)
                Text("Choose Category")
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                    ForEach(recipeCategories, id: \.idCategory) { category in
                        NavigationLink(destination: RecipeListView(selectedCategory: category.strCategory)) {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: category.strCategoryThumb)) { phase in
                                    switch phase {
                                    case .empty:
                                        Color.gray
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .clipped()
                                    case .failure(_):
                                        Color.gray
                                    @unknown default:
                                        Color.gray
                                    }
                                }
                                HStack {
                                    Spacer()
                                    Text(category.strCategory)
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                            }
                            .padding(30)
                        }
                    }
                }
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
