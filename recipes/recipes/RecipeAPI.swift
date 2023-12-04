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
    
    var ingredientMeasureArray: [String] {
        var result: [String] = []
        if strIngredient1 != "" {
            result.append("\(strIngredient1) - \(strMeasure1)")
        }
        if !strIngredient2.isEmpty {
            result.append("\(strIngredient2) - \(strMeasure2)")
        }
        if !strIngredient3.isEmpty {
            result.append("\(strIngredient3) - \(strMeasure3)")
        }
        if !strIngredient4.isEmpty {
            result.append("\(strIngredient4) - \(strMeasure4)")
        }
        if !strIngredient5.isEmpty {
            result.append("\(strIngredient5) - \(strMeasure5)")
        }
        if !strIngredient6.isEmpty {
            result.append("\(strIngredient6) - \(strMeasure6)")
        }
        if !strIngredient7.isEmpty {
            result.append("\(strIngredient7) - \(strMeasure7)")
        }
        if !strIngredient8.isEmpty {
            result.append("\(strIngredient8) - \(strMeasure8)")
        }
        if !strIngredient9.isEmpty {
            result.append("\(strIngredient9) - \(strMeasure9)")
        }
        if !strIngredient10.isEmpty {
            result.append("\(strIngredient10) - \(strMeasure10)")
        }
        if !strIngredient11.isEmpty {
            result.append("\(strIngredient11) - \(strMeasure11)")
        }
        if !strIngredient12.isEmpty {
            result.append("\(strIngredient12) - \(strMeasure12)")
        }
        if !strIngredient13.isEmpty {
            result.append("\(strIngredient13) - \(strMeasure13)")
        }
        if !strIngredient14.isEmpty {
            result.append("\(strIngredient14) - \(strMeasure14)")
        }
        if !strIngredient15.isEmpty {
            result.append("\(strIngredient15) - \(strMeasure15)")
        }
        if !strIngredient16.isEmpty {
            result.append("\(strIngredient16) - \(strMeasure16)")
        }
        if !strIngredient17.isEmpty {
            result.append("\(strIngredient17) - \(strMeasure17)")
        }
        if !strIngredient18.isEmpty {
            result.append("\(strIngredient18) - \(strMeasure18)")
        }
        if !strIngredient19.isEmpty {
            result.append("\(strIngredient19) - \(strMeasure19)")
        }
        if !strIngredient20.isEmpty {
            result.append("\(strIngredient20) - \(strMeasure20)")
        }
        return result
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
