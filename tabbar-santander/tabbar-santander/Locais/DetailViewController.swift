//
//  DetailViewController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 14/01/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var annotationSelected: MKAnnotation?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLAbel: UILabel!
    @IBOutlet weak var coordinationsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = annotationSelected?.title ?? ""
        self.subtitleLAbel.text = annotationSelected?.subtitle ?? ""
        self.coordinationsLabel.text = "lat = \(annotationSelected?.coordinate.latitude ?? 0) long = \(annotationSelected?.coordinate.longitude ?? 0)"
        // Do any additional setup after loading the view.
    }

}
