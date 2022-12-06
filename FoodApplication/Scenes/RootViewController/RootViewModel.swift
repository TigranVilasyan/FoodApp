//
//  RootViewModel.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation
import Swinject



protocol RootViewModelInput: AnyObject {
    func viewDidLoad()
}


protocol RootViewModelOutput: AnyObject {
    func getRecpies(recipe: String,offSet: Int, complition: @escaping (Recipe?) -> ())
}

protocol RootViewModelType: AnyObject {
    var inputs: RootViewModelInput { get }
    var outputs: RootViewModelOutput { get }
}

class RootViewModel: RootViewModelInput,
                     RootViewModelOutput,
                     RootViewModelType {

    //MARK: Properties
    var inputs: RootViewModelInput { return self }
    var outputs: RootViewModelOutput { return self }
    
    
    //MARK: Output Methods
    func getRecpies(recipe: String,offSet: Int, complition: @escaping (Recipe?) -> ()) {
        BackendRequest().getRecipe(recipe: recipe, offSet: offSet) { [weak self] data in
            guard let _ = self else {return}
            if let data = data {
                complition(data)
            }
        }
    }
    
    //MARK: Input Methods
    func viewDidLoad() {
        
    }
    
}
