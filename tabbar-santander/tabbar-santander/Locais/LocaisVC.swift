//
//  LocaisVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 11/01/21.
//

import UIKit
import MapKit

class LocaisVC: BaseViewController {

    @IBOutlet weak var myMapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: -23.5654197, longitude: -46.6545216)
        self.centerMapOnLocation(location: initialLocation)
        
        let point = Agencia(title: "Trianon Masp", subtitle: "A melhor agencia do mundo", categoria: "AG", lat: "-23.5614142", lng: "-46.6558819")
        
        self.myMapView.addAnnotation(point)
        
        // Do any additional setup after loading the view.
    }


    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        self.myMapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLocationAuthorizationSatatus()

    }
    
    
    let locationManager = CLLocationManager()
    
    func checkLocationAuthorizationSatatus() {
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        if CLLocationManager.authorizationStatus() ==  .authorizedWhenInUse {
            self.myMapView.showsUserLocation = true
        }else {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
    }
}

extension LocaisVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations.first)
        self.checkLocationAuthorizationSatatus()
    }
}
