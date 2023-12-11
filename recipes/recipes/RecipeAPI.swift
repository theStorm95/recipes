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
    let categories: [Catagory]
}

struct Catagory: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
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
        if let unwrappedIngredient1 = strIngredient1, !unwrappedIngredient1.isEmpty {
            result.append("\(unwrappedIngredient1) - \(strMeasure1)")
        }
        if let unwrappedIngredient2 = strIngredient2, !unwrappedIngredient2.isEmpty {
            result.append("\(unwrappedIngredient2) - \(strMeasure2)")
        }
        if let unwrappedIngredient3 = strIngredient3, !unwrappedIngredient3.isEmpty {
            result.append("\(unwrappedIngredient3) - \(strMeasure3)")
        }
        if let unwrappedIngredient4 = strIngredient4, !unwrappedIngredient4.isEmpty {
            result.append("\(unwrappedIngredient4) - \(strMeasure4)")
        }
        if let unwrappedIngredient5 = strIngredient5, !unwrappedIngredient5.isEmpty {
            result.append("\(unwrappedIngredient5) - \(strMeasure5)")
        }
        if let unwrappedIngredient6 = strIngredient6, !unwrappedIngredient6.isEmpty {
            result.append("\(unwrappedIngredient6) - \(strMeasure6)")
        }
        if let unwrappedIngredient7 = strIngredient7, !unwrappedIngredient7.isEmpty {
            result.append("\(unwrappedIngredient7) - \(strMeasure7)")
        }
        if let unwrappedIngredient8 = strIngredient8, !unwrappedIngredient8.isEmpty {
            result.append("\(unwrappedIngredient8) - \(strMeasure8)")
        }
        if let unwrappedIngredient9 = strIngredient9, !unwrappedIngredient9.isEmpty {
            result.append("\(unwrappedIngredient9) - \(strMeasure9)")
        }
        if let unwrappedIngredient10 = strIngredient10, !unwrappedIngredient10.isEmpty {
            result.append("\(unwrappedIngredient10) - \(strMeasure10)")
        }
        if let unwrappedIngredient11 = strIngredient11, !unwrappedIngredient11.isEmpty {
            result.append("\(unwrappedIngredient11) - \(strMeasure11)")
        }
        if let unwrappedIngredient12 = strIngredient12, !unwrappedIngredient12.isEmpty {
            result.append("\(unwrappedIngredient12) - \(strMeasure12)")
        }
        if let unwrappedIngredient13 = strIngredient13, !unwrappedIngredient13.isEmpty {
            result.append("\(unwrappedIngredient13) - \(strMeasure13)")
        }
        if let unwrappedIngredient14 = strIngredient14, !unwrappedIngredient14.isEmpty {
            result.append("\(unwrappedIngredient14) - \(strMeasure14)")
        }
        if let unwrappedIngredient15 = strIngredient15, !unwrappedIngredient15.isEmpty {
            result.append("\(unwrappedIngredient15) - \(strMeasure15)")
        }
        if let unwrappedIngredient16 = strIngredient16, !unwrappedIngredient16.isEmpty {
            result.append("\(unwrappedIngredient16) - \(strMeasure16)")
        }
        if let unwrappedIngredient17 = strIngredient17, !unwrappedIngredient17.isEmpty {
            result.append("\(unwrappedIngredient17) - \(strMeasure17)")
        }
        if let unwrappedIngredient18 = strIngredient18, !unwrappedIngredient18.isEmpty {
            result.append("\(unwrappedIngredient18) - \(strMeasure18)")
        }
        if let unwrappedIngredient19 = strIngredient19, !unwrappedIngredient19.isEmpty {
            result.append("\(unwrappedIngredient19) - \(strMeasure19)")
        }
        if let unwrappedIngredient20 = strIngredient20, !unwrappedIngredient20.isEmpty {
            result.append("\(unwrappedIngredient20) - \(strMeasure20)")
        }
        return result
    }
}

class APIManager {
    static func fetchMealCatagories(completion: @escaping (Result<[Catagory], Error>) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
            
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let catagoryResponse = try decoder.decode(CatagoryResponse.self, from: data)
                    let catagory = catagoryResponse.categories
                    completion(.success(catagory))
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
