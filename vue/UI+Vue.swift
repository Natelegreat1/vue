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

enum ButtonStyle {
    case large
    case liked
    case subtle
    case unliked
}

extension UIButton {
    
    func style(withButtonStyle style: ButtonStyle = .large) {
        switch (style) {
        case .liked:
            self.setTitle(nil, for: .normal)
            self.setImage(#imageLiteral(resourceName: "heart-filled").withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = UIColor.vueGreen
            self.imageView?.contentMode = .scaleAspectFit
        case .unliked:
            self.setTitle(nil, for: .normal)
            self.setImage(#imageLiteral(resourceName: "heart-outline").withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = UIColor.vueLightGrey
            self.imageView?.contentMode = .scaleAspectFit
        case .subtle:
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
            self.setTitleColor(UIColor.white, for: .normal)
            self.backgroundColor = UIColor.clear
        default:
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            self.setTitleColor(UIColor.white, for: .normal)
            self.backgroundColor = UIColor.vueDarkGreen
            self.addCircularBorder(withColor: UIColor.vueLightGrey, withWidth: 2.0)
        }
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

extension UIViewController {
    func addLogoToNavTileView(withFadeInEffect shouldFadeIn: Bool = false) {
        let imageView = UIImageView()
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imageView.contentMode = .scaleAspectFit
        
        if shouldFadeIn == true {
            imageView.alpha = 0
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 175, height: 40))
        imageView.frame = view.frame

        imageView.image = #imageLiteral(resourceName: "logo")
    
        imageView.center = view.center
        view.addSubview(imageView)
        self.navigationItem.titleView = view

        self.navigationItem.title = " "
        
        if shouldFadeIn == true {
            imageView.fadeIn()
        }
    }
}
