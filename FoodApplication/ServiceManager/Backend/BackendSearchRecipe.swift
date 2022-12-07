//
//  BackendSearchRecipe.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation
import Alamofire

extension BackendRequest {
    
    func getRecipe(recipe: String,offSet: Int, complition: @escaping (Recipe?) -> ()) {
        let request = RecipeRequest.getRecipe(recipe: recipe,offSet: offSet)
        let headers = request.headers
        let params = request.parameters
        let url = URL(string: basePathRecipes + request.path)!
        BackendRequest.shared.requestWith(url: url, method: request.method,params: params,headers: headers) { resposne in
            do {
                let data = try JSONDecoder().decode(Recipe.self, from: resposne as! Data)
                complition(data)
            } catch {
                print(error)
                complition(nil)
            }
        }
    }
    
    func getRecipeDetail(id: Int, complition: @escaping (RecipeDetail?) -> ()) {
        let request = RecipeRequest.getRecipeDetails(id: id)
        let headers = request.headers
        let params = request.parameters
        let url = URL(string: basePathRecipes + request.path)!
        BackendRequest.shared.requestWith(url: url, method: request.method,params: params,headers: headers) { resposne in
            do {
                let data = try JSONDecoder().decode(RecipeDetail.self, from: resposne as! Data)
                complition(data)
            } catch {
                print(error)
                complition(nil)
            }
        }
    }
    
    func getRecipeByIngredients(recipe: String,offSet: Int, complition: @escaping (Ingredient?) -> ()) {
        let request = RecipeRequest.gerRecipeByIngredients(recipe: recipe, offSet: offSet)
        let headers = request.headers
        let params = request.parameters
        let url = URL(string: basePathIngredients + request.path)!
        BackendRequest.shared.requestWith(url: url, method: request.method,params: params,headers: headers) { resposne in
            if resposne is AFError {
                complition(Ingredient(offset: 0, number: 0, totalResults: 0, results: []))
                return
            }
            do {
                let data = try JSONDecoder().decode(Ingredient.self, from: resposne as! Data)
                complition(data)
            } catch {
                print(error)
                complition(nil)
            }
        }
    }
    
    func getIngredientDetial(id: Int, complition: @escaping (IngredientDetail?) -> ()) {
        let request = RecipeRequest.getIngredentDetails(id: id)
        let headers = request.headers
        let params = request.parameters
        let url = URL(string: basePathIngredients + request.path)!
        BackendRequest.shared.requestWith(url: url, method: request.method,params: params,headers: headers) { resposne in
            if resposne is AFError {
                complition(IngredientDetail(id: 1, name: "Test", image: ""))
                return
            }
            do {
                let data = try JSONDecoder().decode(IngredientDetail.self, from: resposne as! Data)
                complition(data)
            } catch {
                print(error)
                complition(nil)
            }
        }
    }
}
