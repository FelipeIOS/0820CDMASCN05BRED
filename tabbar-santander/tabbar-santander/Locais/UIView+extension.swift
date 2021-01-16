//
//  UIView+extension.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 15/01/21.
//

import Foundation
import UIKit

extension UIView {
    
//
//    func addBlurEffect() {
//        
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = self.bounds
//        blurredEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        
//        self.addSubview(blurredEffectView)
//        
//    }
    
    func addBlueEffect(style: UIBlurEffect.Style? = .dark) {
        
        let blurEffect = UIBlurEffect(style: style ?? .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.addSubview(blurredEffectView)
        
    }
    
    func removeBlurEffect() {
        
        for subView in self.subviews {
            
            if subView is UIVisualEffectView {
                subView.removeFromSuperview()
            }
        }
    }
    
}

