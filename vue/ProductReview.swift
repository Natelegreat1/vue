//
//  ProductReview.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ProductReview: NSObject {
    var customerName: String
    var text: String
    var rating: Int
    var source: String
    
    override init() {
        self.customerName = "Jane Doe"
        self.text = "This is a review. It's pretty long but it could be longer. Hopefully this is informative at least!"
        self.rating = 4
        self.source = "Walmart"
    }
}
