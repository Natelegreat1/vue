//
//  Product.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class Product: NSObject {
    var title: String
    var type: String
    var reviews: [ProductReview]
    var image: UIImage
    
    override init() {
        self.title = "Senorita Margarita Shampoo, Shower Gel & Bubble Bath"
        self.type = "Shampoo"
        self.image = #imageLiteral(resourceName: "marg")
        self.reviews = [ProductReview]()
        
        for _ in 0...5 {
            let review = ProductReview()
            self.reviews.append(review)
        }
    }
}
