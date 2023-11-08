//
//  RecipeAPI.swift
//  recipes
//
//  Created by Michael Carey on 11/7/23.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    // Add more properties as needed
}

class APIManager {
    static func fetchRandomMeal(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let mealResponse = try decoder.decode(MealResponse.self, from: data)
                    let meals = mealResponse.meals
                    completion(.success(meals))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
