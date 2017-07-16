//
//  SearchViewController.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-13.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    class var viewController: SearchViewController {
        let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
        return vc as! SearchViewController
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = NSLocalizedString("Search", comment:"")
            searchBar.searchBarStyle = .prominent
//            searchBar.delegate = self
            searchBar.style()
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.styleForProducts()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("Search", comment: "").uppercased()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissSearch))
        
        self.view.backgroundColor = UIColor.vueLightGrey
    }

    func dismissSearch() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return ProductManager.current.products.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let product = ProductManager.current.products[indexPath.row]
        cell.configure(withProduct: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = ProductManager.current.products[indexPath.row]

        let vc = ProductViewController.viewController
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
