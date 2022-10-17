//
//  ListingViewModel.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 4/26/21.
//

import Foundation
import Firebase
import Combine
import CoreLocation

class ListingViewModel:ObservableObject {
    
    @Published var coordinate = CLLocationCoordinate2D()
    
    func getLocation(listing: Listing)  {
        
        var location = CLLocation()
        
        let address = "\(listing.city),\(listing.state)"
        
        print("ADDRESS: \(address)")
        
        CLGeocoder().geocodeAddressString(address) {
            (placemarks, error) in
            guard
                let placemarks = placemarks
            
            else {
                // handle no location found
                return
            }
            location = (placemarks.first?.location)!
            self.coordinate = location.coordinate
        }
        
    }
    
    func saveListing(listingId: String){
        
        let user = Auth.auth().currentUser
        guard let userId = user?.uid else {
            return
        }
        
        let ref = Database.database().reference(withPath: "userlistings")
        
        let newUserRef = ref.child("\(userId)")
        
        let thisUserPostRef = newUserRef.childByAutoId //create a new post node
        
        let dictJob: [String: String] = ["job": "\(listingId)"]
        thisUserPostRef().setValue(dictJob)
        
    }
}

