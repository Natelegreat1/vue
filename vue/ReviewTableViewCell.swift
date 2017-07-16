//
//  ReviewTableViewCell.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    var nib: UINib {
        return UINib(nibName: ReviewTableViewCell.name, bundle: nil)
    }
    static let identifier = "reviewCell"
    static let name = "ReviewTableViewCell"

    @IBOutlet weak var innerView: UIView! {
        didSet {
            innerView.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var customerLabel: UILabel! {
        didSet {
            customerLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
        }
    }
    @IBOutlet weak var ratingsImageView: UIImageView! {
        didSet {
            ratingsImageView.image = #imageLiteral(resourceName: "5-of-5-star-rating").withRenderingMode(.alwaysTemplate)
            ratingsImageView.tintColor = UIColor.vueGreen
            ratingsImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var ratingLabel: UILabel! {
        didSet {
            ratingLabel.numberOfLines = 0
            ratingLabel.textAlignment = .justified
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    func configure(withReview review: ProductReview) {
        self.customerLabel.text = review.customerName

        self.ratingLabel.text = review.text
    }
    
}
