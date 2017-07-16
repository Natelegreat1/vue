//
//  ScannedProductViewController.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ScannedProductViewController: UIViewController {

    class var viewController: ScannedProductViewController {
        let vc = UIStoryboard(name: "ScannedProduct", bundle: nil).instantiateViewController(withIdentifier: "ScannedProductViewController")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc as! ScannedProductViewController
    }
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }
    }
    
    @IBOutlet weak var brandLabel: UILabel! {
        didSet {
            brandLabel.text = "La mer".uppercased()
            brandLabel.font = UIFont.boldSystemFont(ofSize: 25)
            brandLabel.textColor = UIColor.vueLightGrey
        }
    }
    @IBOutlet weak var typeLabel: UILabel! {
        didSet {
            typeLabel.text = "cleansing powder".lowercased()
            typeLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
            typeLabel.textColor = UIColor.vueLightGrey
        }
    }
    @IBOutlet weak var ratingImageView: UIImageView! {
        didSet {
            ratingImageView.contentMode = .scaleAspectFit
            ratingImageView.image = #imageLiteral(resourceName: "5-of-5-star-rating").withRenderingMode(.alwaysTemplate)
            ratingImageView.tintColor = UIColor.vueLightGrey
        }
    }
    @IBOutlet weak var reviewsCountLabel: UILabel! {
        didSet {
            reviewsCountLabel.text = "75 reviews"
            reviewsCountLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
            reviewsCountLabel.textColor = UIColor.white
        }
    }
    @IBOutlet weak var viewButton: UIButton! {
        didSet {
            viewButton.setTitle(NSLocalizedString("Reviews", comment: "").uppercased(), for: .normal)
            viewButton.addTarget(self, action: #selector(self.viewProduct), for: .touchUpInside)
            viewButton.style()
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.setTitle(NSLocalizedString("Add to basket", comment: "").uppercased(), for: .normal)
            addButton.addTarget(self, action: #selector(self.addToBasket), for: .touchUpInside)
            addButton.style()
        }
    }

    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle(NSLocalizedString("", comment: ""), for: .normal)
            closeButton.setImage(#imageLiteral(resourceName: "exit"), for: .normal)
            closeButton.addTarget(self, action: #selector(self.dismissProduct), for: .touchUpInside)
            closeButton.tintColor = UIColor.white
        }
    }
    
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        _ = self.view.addBlurEffect(.dark)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissProduct))
        self.view.addGestureRecognizer(tapGesture)
        
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
        self.dismissProduct()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.mainView.addBorder(withCornerRadius: 3.0, withColor: UIColor.vueLightGrey, withWidth: 2.0)
    }
    
    func viewProduct() {
        let vc = ProductViewController.viewController
        vc.product = self.product
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

    func dismissProduct() {
        self.dismiss(animated: true, completion: nil)
    }
}
