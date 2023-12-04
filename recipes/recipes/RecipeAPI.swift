//
//  RecipeAPI.swift
//  recipes
//
//  Created by Michael Carey on 11/7/23.
//

import Foundation

struct CatagoryMealsResponse: Codable {
    let meals: [CatagoryMeals]
}

struct CatagoryMeals: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealResponse: Codable {
    let meals: [Meal]
}

struct CatagoryResponse: Codable {
    let meals: [Catagory]
}

struct Catagory: Codable {
    let strCategory: String
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strIngredient6: String
    let strIngredient7: String
    let strIngredient8: String
    let strIngredient9: String
    let strIngredient10: String
    let strIngredient11: String
    let strIngredient12: String
    let strIngredient13: String
    let strIngredient14: String
    let strIngredient15: String
    let strIngredient16: String
    let strIngredient17: String
    let strIngredient18: String
    let strIngredient19: String
    let strIngredient20: String
    let strMeasure1: String
    let strMeasure2: String
    let strMeasure3: String
    let strMeasure4: String
    let strMeasure5: String
    let strMeasure6: String
    let strMeasure7: String
    let strMeasure8: String
    let strMeasure9: String
    let strMeasure10: String
    let strMeasure11: String
    let strMeasure12: String
    let strMeasure13: String
    let strMeasure14: String
    let strMeasure15: String
    let strMeasure16: String
    let strMeasure17: String
    let strMeasure18: String
    let strMeasure19: String
    let strMeasure20: String
    
    private func getValue(forKey key: String) -> String? {
            let mirror = Mirror(reflecting: self)
            for child in mirror.children {
                if let label = child.label, label == key, let value = child.value as? String, !value.isEmpty {
                    return value
                }
            }
            return nil
        }
}

class APIManager {
    static func fetchMealCatagories(completion: @escaping (Result<[Catagory], Error>) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?c=list")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let catagoryResponse = try decoder.decode(CatagoryResponse.self, from: data)
                    let catagories = catagoryResponse.meals
                    completion(.success(catagories))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    static func fetchCatagoryMeals(categoryType: String, completion: @escaping (Result<[CatagoryMeals], Error>) -> Void) {
        
        let lowercaseCatType = categoryType.lowercased()
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(lowercaseCatType)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let catagorymealsResponse = try decoder.decode(CatagoryMealsResponse.self, from: data)
                    let catagorymeals = catagorymealsResponse.meals
                    completion(.success(catagorymeals))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    static func fetchMealDetails(id: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching meal details:", error)
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let mealResponse = try decoder.decode(MealResponse.self, from: data)
                    let meals = mealResponse.meals
                    print(meals)
                    completion(.success(meals))
                } catch {
                    print("Error decoding meal details:", error)
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
