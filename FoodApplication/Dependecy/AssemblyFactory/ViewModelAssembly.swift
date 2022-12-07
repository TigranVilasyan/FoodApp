//
//  ViewModelAssembly.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation
import Swinject


class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        //MARK: RootViewModelType
        container.register(RootViewModelType.self) { r in
            return RootViewModel()
        }.inObjectScope(.container)
        
        //MARK: RecipeDetailViewModelType
        container.register(RecipeDetailViewModelType.self) { r in
            return RecipeDetailViewModel()
        }.inObjectScope(.container)
        
    }
}
