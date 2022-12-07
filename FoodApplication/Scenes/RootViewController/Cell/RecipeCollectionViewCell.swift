//
//  RecipeCollectionViewCell.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import UIKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier: String = "RecipeCollectionViewCell"
    
    //MARK: UI Elements
    lazy var recipeImage: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    lazy var recipeTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(recipe: RecipeResult) {
        setupConstraints()
        recipeImage.sd_setImage(with: URL(string: recipe.image))
        recipeTitleLabel.text = recipe.title
    }
    
    func setup(ingredient: IngredientResult) {
        setupConstraints()
        recipeImage.sd_setImage(with: URL(string: ingredient.image),placeholderImage: UIImage(named: "fast-food-svgrepo-com"))
        recipeTitleLabel.text = ingredient.name
    }
    
    //MARK: SetupUI and Constraints
    func setupConstraints() {
        //Image Constraints
        contentView.addSubview(recipeImage)
        recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        recipeImage.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        recipeImage.heightAnchor.constraint(equalTo: recipeImage.widthAnchor, multiplier: 1.0).isActive = true
        
        //Recipe Constraints
        contentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 8.0).isActive = true
        recipeTitleLabel.leftAnchor.constraint(equalTo: recipeImage.leftAnchor, constant: 0).isActive = true
        recipeTitleLabel.rightAnchor.constraint(equalTo: recipeImage.rightAnchor, constant: 0).isActive = true
        recipeTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0).isActive = true
    }
}
