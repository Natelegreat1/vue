//
//  HUD.swift
//  StudyBuddy
//
//  Created by Nathaniel Blumer on 2016-11-04.
//  Copyright © 2016 StudyBuddy. All rights reserved.
//

import UIKit
import SVProgressHUD

class HUD {
    
    enum HudStyle {
        case liked
        case unliked
    }
    
    class func style() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 12))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.vueDarkGreen)
        SVProgressHUD.setRingThickness(4)
        SVProgressHUD.setMaximumDismissTimeInterval(1.0)
        SVProgressHUD.setSuccessImage(#imageLiteral(resourceName: "heart-filled"))
        SVProgressHUD.setErrorImage(#imageLiteral(resourceName: "heart-outline"))
        SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 100))
    }
    
    class func style(withHudStyle style: HudStyle) {

        switch style {
        case .liked:
            SVProgressHUD.setForegroundColor(UIColor.vueDarkGreen)
            SVProgressHUD.setBackgroundColor(UIColor.white)

        case .unliked:
            SVProgressHUD.setForegroundColor(UIColor.vueDarkGrey)
            SVProgressHUD.setBackgroundColor(UIColor.white)
        }
    }
    
    class func showInfomatic(withText text: String?) {
        SVProgressHUD.showInfo(withStatus: text)
    }
    
    class func showSuccess(withText text: String?) {
        HUD.style(withHudStyle: .liked)
        SVProgressHUD.showSuccess(withStatus: text)
    }
    
    class func showError(withText text: String?) {
        HUD.dismiss()
        HUD.style(withHudStyle: .unliked)
        SVProgressHUD.showError(withStatus: text)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
}
