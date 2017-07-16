//
//  CameraViewController.swift
//  vue
//
//  Created by Nathaniel Blumer on 2017-07-13.
//  Copyright © 2017 Nathaniel Blumer. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    class var viewController: CameraViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CameraViewController")
        return vc as! CameraViewController
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = NSLocalizedString("Search", comment:"")
            searchBar.searchBarStyle = .minimal
            searchBar.delegate = self
            searchBar.style()
        }
    }
    @IBOutlet weak var compareButton: UIButton! {
        didSet {
            compareButton.setTitle(NSLocalizedString("Basket", comment: "").uppercased(), for: .normal)
            compareButton.style()
            compareButton.addTarget(self, action: #selector(self.showBasket), for: .touchUpInside)
        }
    }
    
    let session: AVCaptureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        session.sessionPreset = AVCaptureSessionPresetHigh
        if let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) {
            do {
                try session.addInput(AVCaptureDeviceInput(device: device))
            } catch {
                print(error.localizedDescription)
            }            
        }
        
        guard let previewLayer = AVCaptureVideoPreviewLayer(session: session) else {
            return
        }
        
        // Add the preview layer to our view
        self.view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = self.view.layer.bounds
        
        session.startRunning()
    }
    
    func showBasket() {
        let vc = BasketViewController.viewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let vc = ScannedProductViewController.viewController
            vc.product = ProductManager.current.products.first
            self.present(vc, animated: true, completion: nil)
        }
    }

}

extension CameraViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if let nav = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as? UINavigationController {
            nav.modalTransitionStyle = .crossDissolve
            nav.modalPresentationStyle = .overCurrentContext
            self.present(nav, animated: true, completion: nil)
        }
        return false
    }
}
