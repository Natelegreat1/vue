//
//  BasketViewController.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-16.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    class var viewController: UINavigationController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController")
        let nav = UINavigationController(rootViewController: vc)
        return nav
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
  
        self.navigationItem.title = NSLocalizedString("My Vue", comment: "").uppercased()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissBasket))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)

        self.view.backgroundColor = UIColor.vueLightGrey
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if ProductManager.current.isBasketEmpty == false {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Clear", comment: ""), style: .plain, target: self, action: #selector(self.clearBasket))
        }
    }
    
    func dismissBasket() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clearBasket() {
        ProductManager.current.clearBasket()
        self.tableView.reloadData()
        self.navigationItem.rightBarButtonItem = nil
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductManager.current.basket.count
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
        
        let product = ProductManager.current.basket[indexPath.row]
        cell.configure(withProduct: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = ProductManager.current.basket[indexPath.row]
        
        let vc = ProductViewController.viewController
        vc.selectedProduct = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .destructive, title: NSLocalizedString("Remove", comment: "")) { (action, indexPath) in
            let product = ProductManager.current.basket[indexPath.row]
            ProductManager.current.remove(productFromBasket: product)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [remove]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
}

