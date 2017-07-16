//
//  ProductTableViewCell.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    var nib: UINib {
        return UINib(nibName: ProductTableViewCell.name, bundle: nil)
    }
    static let identifier = "productCell"
    static let name = "ProductTableViewCell"

    
    @IBOutlet weak var innerView: UIView! {
        didSet {
            innerView.backgroundColor = UIColor.white
            innerView.clipsToBounds = true
        }
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
    
    @IBOutlet weak var ratingsCountLabel: UILabel! {
        didSet {
            ratingsCountLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        }
    }
    @IBOutlet weak var ratingImageView: UIImageView! {
        didSet {
            ratingImageView.image = #imageLiteral(resourceName: "5-of-5-star-rating").withRenderingMode(.alwaysTemplate)
            ratingImageView.tintColor = UIColor.vueGreen
        }
    }
    
    @IBOutlet weak var disclosureImageView: UIImageView! {
        didSet {
            disclosureImageView.contentMode = .scaleAspectFit
            disclosureImageView.image = #imageLiteral(resourceName: "disclosure").withRenderingMode(.alwaysTemplate)
            disclosureImageView.tintColor = UIColor.vueDarkGrey
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.contentView.clipsToBounds = true
    }
    
    func configure(withProduct product: Product) {
        self.productImageView.image = product.image
        self.productLabel.text = product.title
        
        let count = product.reviews.count
        if count == 1 {
            self.ratingsCountLabel.text = "1 \(NSLocalizedString("review", comment: ""))"
        } else {
            self.ratingsCountLabel.text = "\(count) \(NSLocalizedString("reviews", comment: ""))"
        }
    }
}
