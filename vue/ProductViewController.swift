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
            productImageView.addBorder(withCornerRadius: 3.0, withColor: UIColor.vueDarkGrey, withWidth: 2.0)

        }
    }
    @IBOutlet weak var productLabel: UILabel! {
        didSet {
            productLabel.numberOfLines = 0
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
            addButton.style(withButtonStyle: .unliked)
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
    
    var selectedProduct: Product?
    fileprivate var product: Product {
        guard let product = self.selectedProduct else {
            NSLog("Missing product!")
            return Product()
        }
        return product
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addLogoToNavTileView()
        
        if self.navigationController?.viewControllers.first == self {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissProduct))
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        
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
            addButton.style(withButtonStyle: .liked)
        } else {
            addButton.style(withButtonStyle: .unliked)
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("Reviews", comment: "").uppercased()
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
