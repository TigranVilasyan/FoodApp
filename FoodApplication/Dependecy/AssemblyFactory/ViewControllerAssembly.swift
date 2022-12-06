//
//  ViewControllerAssembly.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import Foundation

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        //MARK: RootViewController
        container.register(RootViewController.self) { r in
            let vc = Controllers().rootViewController()
            let viewModel = container.resolve(RootViewModelType.self)!
            vc.injection(viewModel: viewModel)
            return vc
        }.inObjectScope(.container)
        
        //MARK: RecipeDetailViewController
        container.register(RecipeDetailViewController.self) { r in
            let vc = Controllers().recipeDetailViewController()
            let viewModel = container.resolve(RecipeDetailViewModelType.self)!
            vc.injection(viewModel: viewModel)
            return vc
        }.inObjectScope(.weak)
    }
}
