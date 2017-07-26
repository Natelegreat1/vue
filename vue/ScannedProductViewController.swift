//
//  ScannedProductViewController.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

protocol ScannedProductDelegate: class {
    func didRequestMoreInformation(forProduct product: Product)
}

class ScannedProductViewController: UIViewController {

    class var viewController: ScannedProductViewController {
        let vc = UIStoryboard(name: "ScannedProduct", bundle: nil).instantiateViewController(withIdentifier: "ScannedProductViewController")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc as! ScannedProductViewController
    }
    
    weak var delegate: ScannedProductDelegate?
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.addToBasket))
            tapGesture.numberOfTapsRequired = 2
            
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.viewProduct))
            swipeGesture.direction = .up
            mainView.addGestureRecognizer(swipeGesture)
            mainView.addGestureRecognizer(tapGesture)
            mainView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
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
    @IBOutlet weak var detailsInstructionLabel: UILabel! {
        didSet {
            detailsInstructionLabel.text = NSLocalizedString("Swipe for more information", comment: "")
            detailsInstructionLabel.textAlignment = .center
            detailsInstructionLabel.textColor = UIColor.white
            detailsInstructionLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
        }
    }
    @IBOutlet weak var viewButton: UIButton! {
        didSet {
            viewButton.setTitle(nil, for: .normal)
            viewButton.addTarget(self, action: #selector(self.viewProduct), for: .touchUpInside)
            viewButton.setImage(#imageLiteral(resourceName: "down").withRenderingMode(.alwaysTemplate), for: .normal)
            viewButton.imageView?.contentMode = .center
            viewButton.tintColor = UIColor.white
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.style(withButtonStyle: .unliked)
            addButton.addTarget(self, action: #selector(self.addToBasket), for: .touchUpInside)
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

        self.view.backgroundColor = UIColor.clear
        
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
            HUD.showError(withText: nil)
        } else {
            ProductManager.current.add(productToBasket: self.product)
            HUD.showSuccess(withText: nil)
        }
        
        self.configureCTAButton()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.mainView.addBorder(withCornerRadius: 3.0, withColor: UIColor.vueLightGrey, withWidth: 2.0)
    }
    
    func viewProduct() {
        self.dismiss(animated: true) { 
            self.delegate?.didRequestMoreInformation(forProduct: self.product)
        }
    }

    func dismissProduct() {
        self.dismiss(animated: true, completion: nil)
    }
}
