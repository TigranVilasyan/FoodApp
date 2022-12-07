//
//  Ingredient.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 06.12.22.
//

import Foundation


// MARK: - Ingredient
struct Ingredient: Codable {
    let offset: Int
    let number: Int
    let totalResults: Int
    var results: [IngredientResult]
}

// MARK: - IngredientResult
struct IngredientResult: Codable {
    let id: Int
    let name: String
    let image: String
}
