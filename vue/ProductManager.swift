//
//  ProductManager.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

class ProductManager: NSObject {
    private static var privateShared : ProductManager?
    
    class var current: ProductManager { // change class to final to prevent override
        guard let uwShared = privateShared else {
            privateShared = ProductManager()
            return privateShared!
        }
        return uwShared
    }
    
    var products: [Product]!
    private (set) var basket = [Product]()

    fileprivate class func destroy() {
        self.privateShared = nil
    }
    
    fileprivate override init() { //This prevents others from using the default '()' initializer for this class.
        //        print("init User singleton")
    }
    
    deinit {
        //        print("deinit User singleton")
    }
    
    class func reset() {
        ProductManager.destroy()
    }
    
    func loadProducts() {
        var products =  [Product]()
        for _ in 0...5 {
            let product = Product()
            products.append(product)
        }
        self.products = products
    }
    
    var isBasketEmpty: Bool {
        return self.basket.count == 0
    }
    
    func add(productToBasket product: Product) {
        self.basket.append(product)
    }
    
    func remove(productFromBasket product: Product) {
        self.basket.removeObject(product)
    }
    
    func clearBasket() {
        self.basket.removeAll()
    }
}
