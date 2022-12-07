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
    case gerRecipeByIngredients(recipe: String,offSet: Int)
    case getRecipeDetails(id: Int)
    case getIngredentDetails(id:Int)
    
    public var path: String {
        switch self {
        case .getRecipe:
            return "/complexSearch"
        case .getRecipeDetails(let id):
            return "/\(id)/information?includeNutrition=false"
        case .gerRecipeByIngredients:
            return "/search"
        case .getIngredentDetails(let id):
            return "/\(id)/information"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getRecipe:
            return .get
        case .getRecipeDetails:
            return .get
        case .gerRecipeByIngredients:
            return .get
        case .getIngredentDetails:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getRecipe(let recipe,let offSet):
            return ["apiKey": "539aeccb6eb14fabbfbbe868097c9c10",
                    "query": recipe,
                    "number": 20,
                    "offset": offSet]
        case .getRecipeDetails:
            return ["apiKey": "539aeccb6eb14fabbfbbe868097c9c10"]
        case .gerRecipeByIngredients(let recipe,let offSet):
            return ["apiKey": "539aeccb6eb14fabbfbbe868097c9c10",
                    "query": recipe,
                    "number": 20,
                    "offset": offSet,
                    "sort": "calories",
                    "sortDirection": "desc"]
        case .getIngredentDetails:
            return ["apiKey": "539aeccb6eb14fabbfbbe868097c9c10",
                    "amount": 1]
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .getRecipe:
            return nil
        case .getRecipeDetails:
            return nil
        case .gerRecipeByIngredients:
            return nil
        case .getIngredentDetails:
            return nil
        }
    }
}


