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
        
        self.titleLabel.text  = annotationSelected?.title ?? ""
        self.subtitleLabel.text = annotationSelected?.subtitle ?? ""
        self.latLabel.text = "latitude: \(annotationSelected?.coordinate.latitude ?? 0)"
        self.longLabel.text = "longitude: \(annotationSelected?.coordinate.longitude ?? 0)"
    }
    

}
