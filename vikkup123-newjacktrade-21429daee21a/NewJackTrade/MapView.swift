//
//  MapView.swift
//  NewJackTrade
//
//  Created by Kevin Sampson on 3/15/21.
//

import SwiftUI
import MapKit


struct MapView: View {
    @ObservedObject var viewModel: ListingViewModel
    @State private var region = MKCoordinateRegion()
    @State private var locations = [Location]()
    
    var body: some View{
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapMarker(coordinate: location.coordinate)
            
        }
        .onReceive(viewModel.$coordinate) { coordinate in
            print("onReceive \(coordinate)")
            setRegion(coordinate)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D){
        
        region = MKCoordinateRegion(
            center: coordinate,
            
            span:
                MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        let location = Location(name: "Location", coordinate: coordinate)
        locations.removeAll()
        locations.append(location)
    }
}

struct Location: Identifiable {
    let id = UUID()

    let name: String
    let coordinate: CLLocationCoordinate2D
}

/*
struct MapView: UIViewRepresentable {
    private let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func makeUIView(context: Context) -> MKMapView {
        //print("makeUIView")
        MKMapView()
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        print("updateUIView")
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
        
        view.setRegion(region, animated: true)
        
    }
}
*/
/*
struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView: View {

    let places = [
        Place(name: "british museum", latitude: 51.519581, longitude: -0.127002),
        Place(name: "tower of london", latitude: 51.508052, longitude: -0.076035),
        Place(name: "big ben", latitude: 51.500710, longitude: -0.124617)
    ]
    

    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.514134, longitude: -0.104236),
        span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
    
  
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: places) { place in
            MapMarker(coordinate: place.coordinate)
            
        }
        
        .ignoresSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
 */

