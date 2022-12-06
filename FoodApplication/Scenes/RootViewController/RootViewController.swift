//
//  RootViewController.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 05.12.22.
//

import UIKit

class RootViewController: UIViewController {
    
    var viewModel: RootViewModelType!
    var recipes: Recipe?
    var textSearched: String = ""
    var offSet = 0
    private var collectionView: UICollectionView!
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    lazy var emptyImage: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "box-empty-svgrepo-com")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.isHidden = true
        return theImageView
    }()
    
    func injection(viewModel: RootViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupSearchBar()
        setupCollectionView()
        setupImageView()
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: 100, height: 150)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    
    func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: CGFloat(50))
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        
    }
    
    func setupImageView() {
        self.view.addSubview(emptyImage)
        emptyImage.contentMode = .scaleAspectFit
        emptyImage.topAnchor.constraint(equalTo: view.centerYAnchor,constant: -100).isActive = true
        emptyImage.leftAnchor.constraint(equalTo: view.centerXAnchor,constant: -100).isActive = true
        emptyImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        emptyImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

//MARK: UISearchBarDelegate
extension RootViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        offSet = 0
        self.textSearched = textSearched
        viewModel.outputs.getRecpies(recipe: textSearched, offSet: offSet) { [weak self] recipes in
            guard let recipes = recipes else { return }
            self?.emptyImage.isHidden = !recipes.results.isEmpty
            self?.collectionView.isHidden = recipes.results.isEmpty
            self?.recipes = recipes
            self?.collectionView.reloadData()
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
        vc.id = recipes?.results[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDataSourcePrefetching
extension RootViewController: UICollectionViewDataSource,UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        if (self.recipes!.totalResults > offSet) {
            offSet += 20
            viewModel.outputs.getRecpies(recipe: textSearched, offSet: offSet) { [weak self] recipes in
                guard let results = recipes?.results else { return }
                self?.recipes?.results += results
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as! RecipeCollectionViewCell
        cell.setup(recipe: (self.recipes?.results[indexPath.row])!)
        return cell
    }
    
}
