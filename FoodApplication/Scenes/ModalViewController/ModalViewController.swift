//
//  ModalViewController.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 06.12.22.
//

import UIKit

enum FilterTypes: String {
    case recipe = "Recipe"
    case ingredients = "Ingredients"
}

class ModalViewController: UIViewController {
    
    private var tableView: UITableView!
    let filterTypes: [FilterTypes] = [.recipe,.ingredients]
    var selectedCell = 0
    var previousSelectedValue = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUIBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupUIBar() {
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onClickCancelButton))
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onClickDoneButton))
        )
        self.navigationItem.leftBarButtonItem  = items[0]
        self.navigationItem.rightBarButtonItem  = items[1]
        
        self.navigationController?.toolbar.setItems(items, animated: false)
        
    }
    
    func setupCollectionView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ModalTableViewCell.self, forCellReuseIdentifier: ModalTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
    
    @objc func onClickDoneButton() {
        let vc = Dependency.shared.resolver.resolve(RootViewController.self)!
        previousSelectedValue = selectedCell
        vc.filterType = self.filterTypes[selectedCell]
        vc.searchBar.text = ""
        vc.searchBar.delegate?.searchBar?(vc.searchBar, textDidChange: "")
        navigationController?.dismiss(animated: true)
    }
    
    @objc func onClickCancelButton() {
        let vc = Dependency.shared.resolver.resolve(RootViewController.self)!
        selectedCell = previousSelectedValue
        vc.filterType = self.filterTypes[selectedCell]
        navigationController?.dismiss(animated: true)
    }
}

extension ModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        tableView.reloadData()
    }
}

extension ModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModalTableViewCell.identifier, for: indexPath) as! ModalTableViewCell
        cell.setupUI(type: filterTypes[indexPath.row])
        if indexPath.row == selectedCell {
            cell.selectedImage.isHidden = false
        }
        cell.selectionStyle = .none
        return cell
    }
}
