//
//  UI+Vue.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-15.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit

extension UIColor {
    
    ///01DED9
    class var vueGreen: UIColor {
        return UIColor(red: 1 / 255.0, green: 222 / 255.0, blue: 217 / 255.0, alpha: 1.0)
    }

    ///009087
    class var vueDarkGreen: UIColor {
        return UIColor(red: 0 / 255.0, green: 144 / 255.0, blue: 135 / 255.0, alpha: 1.0)
    }
   
    ///E2E5EC
    class var vueLightGrey: UIColor {
        return UIColor(red: 226 / 255.0, green: 229 / 255.0, blue: 236 / 255.0, alpha: 1.0)
    }
    
    ///DADFE5
    class var vueDarkGrey: UIColor {
        return UIColor(red: 218 / 255.0, green: 223 / 255.0, blue: 229 / 255.0, alpha: 1.0)
    }
}

extension UIButton {
    
    func style() {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = UIColor.vueDarkGreen
        self.addCircularBorder(withColor: UIColor.vueLightGrey, withWidth: 2.0)
    }
}

extension UISearchBar {
    func style() {
        self.tintColor = .vueDarkGreen
        self.barTintColor = UIColor.vueLightGrey
        self.keyboardAppearance = .dark
        self.returnKeyType = .search
    }
}

extension UITableView {
    func styleForProducts() {
        self.separatorStyle = .none
        self.backgroundColor = UIColor.vueLightGrey
        self.keyboardDismissMode = .onDrag
        self.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
