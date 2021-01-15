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
                     
        self.myMapView.delegate = self
        self.myMapView.addAnnotation(agencia)
        
        
        if let locais = self.loadInitialData() {
            
            self.myMapView.addAnnotations(locais.agencias)
        }
    
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
        
        if CLLocationManager.authorizationStatus() ==  .authorizedWhenInUse {
            
            self.myMapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func loadInitialData() -> Locais? {
        
        if let path =  Bundle.main.path(forResource: "Locais", ofType: "json") {
            
            do {

                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let local = try JSONDecoder().decode(Locais.self, from: data)
                
                return local
                
            }catch {
                
                
            }
        }
        return nil
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

extension LocaisVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? Agencia else {return nil}

        let identifier = "marker"
        let view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {

            dequeuedView.annotation = annotation
            view = dequeuedView
        }else{

            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let mapsButton =  UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "map-icon"), for: .normal)
            view.leftCalloutAccessoryView = mapsButton
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font.withSize(12)
            detailLabel.text  = annotation.subtitle
            view.detailCalloutAccessoryView = detailLabel
            
            
        }

        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc: DetailLocaisVC = segue.destination as? DetailLocaisVC,
           let annotation: MKAnnotation = sender as? MKAnnotation {
            
            vc.annotationSelected = annotation
        }
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("\(view.annotation?.title) foi clicada")
        
        self.performSegue(withIdentifier: "DetailLocaisVC", sender: view.annotation)
    }
}
