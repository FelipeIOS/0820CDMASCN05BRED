//
//  DetailLocaisViewController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 15/01/21.
//

import UIKit
import MapKit

class DetailLocaisVC: UIViewController {
    
    var annotationSelected: MKAnnotation?

    @IBOutlet weak var backgroundViewLocal: UIView!
    @IBOutlet weak var localImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    private func setup() {
        
        if let _annotation = self.annotationSelected {
            self.titleLabel.text  = _annotation.title ?? ""
            self.subtitleLabel.text = _annotation.subtitle ?? ""
            self.latLabel.text = "latitude: \(_annotation.coordinate.latitude)"
            self.longLabel.text = "longitude: \(_annotation.coordinate.longitude)"
            self.localImage.image = UIImage(named: (_annotation.title ?? "") ?? "")
            
            self.localImage.addBlueEffect(style: .extraLight)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 5) {
            self.localImage.removeBlurEffect()
        }
    }
    
}
