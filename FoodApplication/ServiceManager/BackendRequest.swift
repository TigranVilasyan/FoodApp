//
//  BackendRequest.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation
import Alamofire

class BackendRequest {
    
    static var shared = BackendRequest()
    let basePathRecipes = "https://api.spoonacular.com/recipes"
    let basePathIngredients = "https://api.spoonacular.com/food/ingredients"
    
    //MARK: -`AF request`
    func requestWith(url: URL, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = nil, complatation: @escaping (Any) -> ()) {
        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...600)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                    complatation(response.error)
                case .success(_):
                    complatation(response.data)
                }
            }
    }
}
