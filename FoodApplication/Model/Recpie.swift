//
//  Recpie.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation


// MARK: - Recipe
struct Recipe: Codable {
    let offset: Int
    let number: Int
    let totalResults: Int
    var results: [RecipeResult]
}

// MARK: - RecipeResult
struct RecipeResult: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
