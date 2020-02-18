
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    let annotation = MKPointAnnotation()
    
    private let locationServices:CLLocationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        locationServices.requestWhenInUseAuthorization()
        locationServices.desiredAccuracy = kCLLocationAccuracyBest
        locationServices.distanceFilter = kCLDistanceFilterNone
        locationServices.startUpdatingLocation()
        
        view.addAnnotation(annotation)
        view.isScrollEnabled = true
        view.isZoomEnabled = true
        view.isRotateEnabled = true
        view.setRegion(region, animated: true)
        view.showsUserLocation = true
        
        if let UserCoordinates = locationServices.location?.coordinate {
            view.setCenter(UserCoordinates, animated: true)
        }
        
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(
        latitude: 1,
        longitude: 1))
    }
}
