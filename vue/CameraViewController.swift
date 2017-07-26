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

    @IBOutlet weak var showBasketButton: UIButton! {
        didSet {
            showBasketButton.setTitle(nil, for: .normal)
            showBasketButton.setImage(#imageLiteral(resourceName: "hearts").withRenderingMode(.alwaysTemplate), for: .normal)
            showBasketButton.tintColor = UIColor.white
            showBasketButton.backgroundColor = UIColor.vueDarkGreen
            showBasketButton.addTarget(self, action: #selector(self.showBasket), for: .touchUpInside)
            showBasketButton.alpha = 0.8
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.clear
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    private let session: AVCaptureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateBasket(withNotification:)), name: Notification.Name.basketUpdated, object: nil)

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
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func didUpdateBasket(withNotification notification: Notification)  {
        guard let product = notification.object as? Product, let _ = ProductManager.current.basket.index(of: product) else {
            self.collectionView.reloadData()
            NSLog("Missing goal in notification")
            return
        }
        self.collectionView.reloadSections(IndexSet(integer: 0))
    }
}

//MARK:- ScannedProductDelegate
extension CameraViewController: ScannedProductDelegate {
    func didRequestMoreInformation(forProduct product: Product) {
        let vc = ProductViewController.viewController
        vc.selectedProduct = product
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

//MARK:- UISearchBarDelegate
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

//MARK:- UICollectionViewDelegate
extension CameraViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductManager.current.basket.count
    }
}

//MARK:- UICollectionViewDataSource
extension CameraViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = ProductManager.current.basket[indexPath.row]

        let vc = ProductViewController.viewController
        vc.selectedProduct = product
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath)
        
        let product = ProductManager.current.basket[indexPath.row]

        cell.backgroundView = UIImageView(image: product.image)
        return cell
    }
}
