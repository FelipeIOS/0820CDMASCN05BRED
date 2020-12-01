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
