//
//  SearchRecipeRequest.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation
import Alamofire

public enum RecipeRequest: BackEndHelperRequest {
    case getRecipe(recipe: String,offSet: Int)
    case getRecipeDetails(id: Int)
  
    
    public var path: String {
        switch self {
        case .getRecipe:
            return "/complexSearch"
        case .getRecipeDetails(let id):
            return "/\(id)/information?includeNutrition=false"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getRecipe:
            return .get
        case .getRecipeDetails:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getRecipe(let recipe,let offSet):
            return ["apiKey": "c57e2bf11985445d85a4255072c9c11c",
                    "query": recipe,
                    "number": 20,
                    "offset": offSet]
        case .getRecipeDetails(id: let id):
            return ["apiKey": "c57e2bf11985445d85a4255072c9c11c",
                    "id": id]
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .getRecipe:
            return nil
        case .getRecipeDetails:
            return nil
        }
    }
}


