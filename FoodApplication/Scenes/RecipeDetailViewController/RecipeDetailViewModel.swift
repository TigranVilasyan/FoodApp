//
//  RecipeDetailViewModel.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 06.12.22.
//

import Foundation

protocol RecipeDetailViewModelInput: AnyObject {
    func viewDidLoad()
}


protocol RecipeDetailViewModelOutput: AnyObject {
    func getRecpieDetail(id: Int, complition: @escaping (RecipeDetail?) -> ())
}

protocol RecipeDetailViewModelType: AnyObject {
    var inputs: RecipeDetailViewModelInput { get }
    var outputs: RecipeDetailViewModelOutput { get }
}

class RecipeDetailViewModel: RecipeDetailViewModelInput,
                             RecipeDetailViewModelOutput,
                             RecipeDetailViewModelType {
    
    //MARK: Properties
    var inputs: RecipeDetailViewModelInput { return self }
    var outputs: RecipeDetailViewModelOutput { return self }
    
    
    //MARK: Output Methods
    func getRecpieDetail(id: Int, complition: @escaping (RecipeDetail?) -> ()) {
        BackendRequest().getRecipeDetail(id: id) { [weak self] recipe in
            guard let _ = self else { return }
            complition(recipe)
            
        }
    }
    
    //MARK: Input Methods
    func viewDidLoad() {
        
    }
}
