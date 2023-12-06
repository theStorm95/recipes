//
//  recipesApp.swift
//  recipes
//
//  Created by Nathan Storm on 11/5/23.
//

import SwiftUI

@main
struct recipesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ShoppingCartManager())
        }
    }
}
