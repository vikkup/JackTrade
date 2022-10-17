//
//  JobListingViewModel.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 4/22/21.
//

import Foundation
import Combine
import Firebase

class JobListingViewModel: ObservableObject {
    
    @Published var listing: Listing
    
    init(){
        listing = Listing(id:"", title:"",services: "",bio:"",phone:"", email:"", city:"", state:"", radius: 0)
    }
    
    func saveListing(){
        
        let user = Auth.auth().currentUser
        guard let userId = user?.uid else {
            return
        }
        let ref = Database.database().reference(withPath: "users")
        
        let newUserRef = ref.child("\(userId)")
        let dictUser: [String: String] = ["title": "\(listing.title)", "services": "\(listing.services)", "bio": "\(listing.bio)", "radius":"\(listing.radius)", "phone":"\(listing.phone)", "email":"\(listing.email)", "city":"\(listing.city)", "state":"\(listing.state)"]
        
        newUserRef.setValue(dictUser) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
}

