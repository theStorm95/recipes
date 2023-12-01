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

struct CatagoryResponse: Codable {
    let catagories: [Catagory]
}

struct Catagory: Codable {
    let strCategory: [String]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    
    var ingredients: [String] {
        var result = [String]()
        for i in 1...20 {
            let key = "strIngredient\(i)"
            if let ingredient = getValue(forKey: key) {
                result.append(ingredient)
            }
        }
        return result
    }

    var measures: [String] {
        var result = [String]()
        for i in 1...20 {
            let key = "strMeasure\(i)"
            if let measure = getValue(forKey: key) {
                result.append(measure)
            }
        }
        return result
    }

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
                    let catagories = catagoryResponse.catagories
                    completion(.success(catagories))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
