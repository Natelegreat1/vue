//
//  ProductViewController.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    class var viewController: ProductViewController {
        let vc = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController")
        return vc as! ProductViewController
    }
    
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            productImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var productLabel: UILabel! {
        didSet {
            productLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var productRatingImageView: UIImageView! {
        didSet {
            productRatingImageView.image = #imageLiteral(resourceName: "5-of-5-star-rating").withRenderingMode(.alwaysTemplate)
            productRatingImageView.tintColor = UIColor.vueGreen
            productRatingImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var ratingsCountLabel: UILabel!{
        didSet {
            ratingsCountLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.setTitle(NSLocalizedString("Add to basket", comment: "").uppercased(), for: .normal)
            addButton.style()
            addButton.addTarget(self, action: #selector(self.addToBasket), for: .touchUpInside)
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ReviewTableViewCell.nib, forCellReuseIdentifier: ReviewTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("Product", comment: "").uppercased()
        
        if self.navigationController?.viewControllers.first == self {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissProduct))
        }
        self.configureForProduct()
    }
    
    func dismissProduct() {
        self.dismiss(animated: true, completion: nil)
    }

    func configureForProduct() {
        self.productImageView.image = self.product.image
        self.productLabel.text = self.product.title
        
        let count = self.product.reviews.count
        if count == 1 {
            self.ratingsCountLabel.text = "1 \(NSLocalizedString("review", comment: ""))"
        } else {
            self.ratingsCountLabel.text = "\(count) \(NSLocalizedString("reviews", comment: ""))"
        }
        
        self.configureCTAButton()
    }
    
    func configureCTAButton() {
        if ProductManager.current.basket.contains(self.product) {
            self.addButton.setTitle(NSLocalizedString("Remove from basket", comment: "").uppercased(), for: .normal)
        } else {
            self.addButton.setTitle(NSLocalizedString("Add to basket", comment: "").uppercased(), for: .normal)
        }
    }
    
    func addToBasket() {
        if ProductManager.current.basket.contains(self.product) {
            ProductManager.current.remove(productFromBasket: self.product)
        } else {
            ProductManager.current.add(productToBasket: self.product)
        }
        
        self.configureCTAButton()
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.product.reviews.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        let review = self.product.reviews[indexPath.row]
        cell.configure(withReview: review)
        return cell
    }
}
