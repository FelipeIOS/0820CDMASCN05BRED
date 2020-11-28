//
//  LoadingView.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 25/11/20.
//

import UIKit
import Lottie

class LoadingView: UIView {

    @IBOutlet weak var animationLoadingView: AnimationView!
    
    func showLoading() {
        
        self.animationLoadingView.loopMode = .loop
        self.animationLoadingView.play()
    }
    
    func hiddenLoading() {
        
        self.animationLoadingView.stop()
        
    }

}
