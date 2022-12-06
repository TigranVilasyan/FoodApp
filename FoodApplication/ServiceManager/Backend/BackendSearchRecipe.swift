//
//  BackendSearchRecipe.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation

extension BackendRequest {
    
    func getRecipe(recipe: String,offSet: Int, complition: @escaping (Recipe?) -> ()) {
        let request = RecipeRequest.getRecipe(recipe: recipe,offSet: offSet)
        let headers = request.headers
        let params = request.parameters
        let url = URL(string: basePath + request.path)!
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
        let url = URL(string: basePath + request.path)!
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
}
