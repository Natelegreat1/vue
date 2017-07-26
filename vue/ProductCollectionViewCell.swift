//
//  ProductCollectionViewCell.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-25.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    var nib: UINib {
        return UINib(nibName: ProductCollectionViewCell.name, bundle: nil)
    }
    static let identifier = "productCell"
    static let name = "ProductCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
