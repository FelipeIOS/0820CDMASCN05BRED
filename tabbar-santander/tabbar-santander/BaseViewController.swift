//
//  BaseViewController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 27/11/20.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func showError(error: ErrorHandler?, preferredStyle: UIAlertController.Style) {
        
        let alert = UIAlertController(title: error?.title, message: error?.errorDescription, preferredStyle: preferredStyle)
        
        let button = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(button)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showLoading() {
        
        self.loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LoadingView
        
        self.loadingView?.frame = self.view.frame
        self.view.addSubview(self.loadingView ?? UIView())
        self.loadingView?.showLoading()
    }
    
    
    func hiddenLoading() {
        self.loadingView?.hiddenLoading()
        self.loadingView?.isHidden = true
    }
    

}
