//
//  AddToCartView.swift
//  recipes
//
//  Created by Michael Carey on 12/5/23.
//

import Foundation
import SwiftUI

class ShoppingCartManager: ObservableObject {
    @Published var shoppingCart: [String] = []
}

struct AddToCartSheet: View {
    @Binding var ingredient: String
    @Binding var isPresented: Bool
    @State private var quantity: Int = 1
    @EnvironmentObject var cartManager: ShoppingCartManager

    init(ingredient: Binding<String>, isPresented: Binding<Bool>) {
        self._ingredient = ingredient
        self._isPresented = isPresented
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Quantity")) {
                    Stepper(value: $quantity, in: 1...10) {
                        Text("Quantity: \(quantity)")
                    }
                }

                Section {
                    Button(action: {
                        cartManager.shoppingCart.append("\(ingredient): \(quantity)")
                    }) {
                        Text("Add to Shopping Cart")
                    }
                }
            }
            .navigationTitle("Add to Cart")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented.toggle()
            })
        }
    }
}

struct ShoppingCartView: View {
    @EnvironmentObject var cartManager: ShoppingCartManager

    var body: some View {
        VStack {
            Text("Shopping Cart")
                .font(.title)

            List(cartManager.shoppingCart, id: \.self) { item in
                Text(item)
            }
        }
        .padding()
    }
}
