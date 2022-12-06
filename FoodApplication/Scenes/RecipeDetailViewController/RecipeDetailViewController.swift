//
//  RecipeDetailViewController.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 06.12.22.
//

import UIKit
import SDWebImage

class RecipeDetailViewController: UIViewController {

    //MARK: Propeties
    var viewModel: RecipeDetailViewModelType!
    var id: Int!
    
    //MARK: UI Elementes
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
    
    lazy var recipeSummaryText: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: Injection
    func injection(viewModel: RecipeDetailViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        viewModel.outputs.getRecpieDetail(id: id) { [weak self] recipeDetail in
            guard let _ = self else { return }
            self?.recipeImage.sd_setImage(with: URL(string: recipeDetail!.image),placeholderImage: UIImage(systemName: "fast-food-svgrepo-com"))
            self?.recipeTitleLabel.text = recipeDetail?.title
            self?.recipeSummaryText.text = recipeDetail?.summary.convertHtmlToNSAttributedString?.string
        }
    }
    
    //MARK: SetupUI
    func setupUI() {
        setupImageUI()
        setupLabelUI()
        setupTextViewUI()
    }
    
    func setupImageUI() {
        view.addSubview(recipeImage)
        recipeImage.contentMode = .scaleAspectFit
        recipeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    }
    
    func setupLabelUI() {
        view.addSubview(recipeTitleLabel)
        recipeTitleLabel.font = UIFont(name: recipeTitleLabel.font.fontName, size: 20)
        recipeTitleLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 32).isActive = true
        recipeTitleLabel.leftAnchor.constraint(equalTo: recipeImage.leftAnchor, constant: 0).isActive = true
        recipeTitleLabel.rightAnchor.constraint(equalTo: recipeImage.rightAnchor, constant: 0).isActive = true
        recipeTitleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
    func setupTextViewUI() {
        view.addSubview(recipeSummaryText)
        recipeSummaryText.font = UIFont(name: recipeTitleLabel.font.fontName, size: 16)
        recipeSummaryText.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 16).isActive = true
        recipeSummaryText.leftAnchor.constraint(equalTo: recipeTitleLabel.leftAnchor, constant: 0).isActive = true
        recipeSummaryText.rightAnchor.constraint(equalTo: recipeTitleLabel.rightAnchor, constant: 0).isActive = true
        recipeSummaryText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0).isActive = true
    }
}
