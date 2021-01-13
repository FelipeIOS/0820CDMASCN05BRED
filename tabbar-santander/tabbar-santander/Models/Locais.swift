
import Foundation
import MapKit

class Locais: Codable {
    let agencias: [Agencia]

    init(agencias: [Agencia]) {
        self.agencias = agencias
    }
}

class Agencia: NSObject, Codable, MKAnnotation {
    
    let title, subtitle, categoria: String?
    let lng, lat: String
    
    var coordinate: CLLocationCoordinate2D {
        let latFloat = Float(self.lat) ?? 0.0
        let lngFloat = Float(self.lng) ?? 0.0
        let lat = CLLocationDegrees(latFloat)
        let lng = CLLocationDegrees(lngFloat)
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    init(title: String, subtitle: String, categoria: String, lat: String, lng: String) {
        self.title = title
        self.subtitle = subtitle
        self.categoria = categoria
        self.lat = lat
        self.lng = lng
    }
    
    
}
