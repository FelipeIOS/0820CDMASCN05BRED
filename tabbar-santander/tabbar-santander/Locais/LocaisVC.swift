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
        
        let initialLocation = CLLocation(latitude: -23.565163997932217, longitude: -46.652365089520536)
        self.centerMapOnLocation(location: initialLocation)
        
        
       
        
        
        let agencia: Agencia = Agencia(title: "Trianon", subtitle: "lugar turistico", categoria: "teste", lat: "-23.565163997932217", lng: "-46.652365089520536")
                                       
        self.myMapView.addAnnotation(agencia)
        
       
        
        // Do any additional setup after loading the view.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius)
        self.myMapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    let locationManager = CLLocationManager()
    
    func checkLocationAuthorizationStatus() {
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            self.myMapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.checkLocationAuthorizationStatus()
    }


}

extension LocaisVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.checkLocationAuthorizationStatus()
    }
}
