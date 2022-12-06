//
//  RecipeDetail.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 06.12.22.
//

import Foundation

// MARK: - RecipeDetail
struct RecipeDetail: Codable {
    let id: Int
    let summary: String
    let title: String
    let image: String
}
