//
//  RootViewController.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import UIKit

class RootViewController: UIViewController {
    
    //MARK: Propeties
    var viewModel: RootViewModelType!
    var recipes: Recipe?
    var ingredients: Ingredient?
    var textSearched: String = ""
    var offSet = 0
    var itemCounter = 20
    var filterType: FilterTypes = .recipe
    
    //MARK: UI Elements
    private var collectionView: UICollectionView!
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.searchBarStyle = UISearchBar.Style.default
        search.placeholder = " E.g. Hotcakes"
        search.sizeToFit()
        search.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: CGFloat(50))
        search.isTranslucent = false
        search.backgroundImage = UIImage()
        search.delegate = self
        navigationItem.titleView = search
        return search
    }()
    
    lazy var emptyImage: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "box-empty-svgrepo-com")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.isHidden = true
        return theImageView
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter-field-32"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func injection(viewModel: RootViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupImageView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearchBar()
        setupButton()
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        searchBar.endEditing(true)
    }
    
    @objc func chooseFilterAction() {
        setupModalView()
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: 100, height: 150)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    
    func setupSearchBar() {
        navigationController?.navigationBar.addSubview(searchBar)
        let leftConstraint = NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .leading, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: searchBar, attribute: .bottom, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .bottom, multiplier: 1, constant: 1)
        
        let topConstraint = NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .top, multiplier: 1, constant: 1)
        
        let widthConstraint = NSLayoutConstraint(item: searchBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.width)
        
        navigationController?.navigationBar.addConstraints([leftConstraint, bottomConstraint, topConstraint, widthConstraint])
    }
    
    func setupButton() {
        filterButton.addTarget(self, action: #selector(chooseFilterAction), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(filterButton)
        filterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor, constant: 0).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        filterButton.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -48).isActive = true
    }
    
    func setupImageView() {
        self.view.addSubview(emptyImage)
        emptyImage.contentMode = .scaleAspectFit
        emptyImage.topAnchor.constraint(equalTo: view.centerYAnchor,constant: -100).isActive = true
        emptyImage.leftAnchor.constraint(equalTo: view.centerXAnchor,constant: -100).isActive = true
        emptyImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        emptyImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupModalView() {
        let vc = Dependency.shared.resolver.resolve(ModalViewController.self)!
        vc.view.backgroundColor = .systemBackground
        let nav = UINavigationController(rootViewController: vc)
        // 1
        nav.modalPresentationStyle = .pageSheet
        // 2
        if let sheet = nav.sheetPresentationController {
            
            // 3
            let size = CGFloat(300)
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return size
                    }
                ]
            } else {
                // Fallback on earlier versions
            }
        }
        // 4
        
        present(nav, animated: true, completion: nil)
    }
}

//MARK: UISearchBarDelegate
extension RootViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        offSet = 0
        if textSearched == "" {
            switch filterType {
            case .recipe:
                searchBar.placeholder = " e.g. Hotcakes"
            case .ingredients:
                searchBar.placeholder = " e.g. Egg"
            }
            self.recipes?.results = []
            self.ingredients?.results = []
            self.emptyImage.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            return
        }
        self.textSearched = textSearched
        switch filterType {
        case .recipe:
            viewModel.outputs.getRecpies(recipe: textSearched, offSet: offSet) { [weak self] recipes in
                guard let recipes = recipes else { return }
                self?.emptyImage.isHidden = !recipes.results.isEmpty
                self?.collectionView.isHidden = recipes.results.isEmpty
                self?.recipes = recipes
                self?.collectionView.reloadData()
            }
        case .ingredients:
            viewModel.outputs.getRecipeByIngredients(recipe: textSearched, offSet: offSet) { [weak self] ingredients in
                guard let ingredients = ingredients else { return }
                self?.emptyImage.isHidden = !ingredients.results.isEmpty
                self?.collectionView.isHidden = ingredients.results.isEmpty
                self?.ingredients = ingredients
                self?.collectionView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

//MARK: UICollectionViewDelegate
extension RootViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Dependency.shared.resolver.resolve(RecipeDetailViewController.self)!
        switch filterType {
        case .recipe:
            vc.id = recipes?.results[indexPath.row].id
        case .ingredients:
            vc.id = ingredients?.results[indexPath.row].id
            
        }
        vc.type = filterType
        filterButton.removeFromSuperview()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDataSourcePrefetching
extension RootViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let recipes = recipes {
            if indexPath.row == recipes.results.count - 1 {
                offSet = indexPath.row + 1
                viewModel.outputs.getRecpies(recipe: textSearched, offSet: offSet) { [weak self] recipes in
                    guard let results = recipes?.results else { return }
                    self?.recipes?.results += results
                    self?.collectionView.reloadData()
                }
                return
            }
        }
        
        if let ingredients = ingredients {
            if indexPath.row == ingredients.results.count - 1 {
                offSet = indexPath.row + 1
                viewModel.outputs.getRecipeByIngredients(recipe: textSearched, offSet: offSet) { [weak self] ingredients in
                    guard let results = ingredients?.results else { return }
                    self?.ingredients?.results += results
                    self?.collectionView.reloadData()
                }
                return
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch filterType {
        case .recipe:
            return recipes?.results.count ?? 0
        case .ingredients:
            return ingredients?.results.count ?? 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as! RecipeCollectionViewCell
        switch filterType {
        case .recipe:
            cell.setup(recipe: (self.recipes?.results[indexPath.row])!)
        case .ingredients:
            cell.setup(ingredient: (self.ingredients?.results[indexPath.row])!)
            
        }
        return cell
    }
    
}
