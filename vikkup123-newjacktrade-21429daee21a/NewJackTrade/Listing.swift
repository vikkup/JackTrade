//
//  Listing.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 3/15/21.
//

import Foundation
import Firebase

struct Listing: Identifiable{
    
    var id: String
    var title: String
    var services: String
    var bio: String
    var phone: String
    var email: String
    var city: String
    var state: String
    var radius: Int
}

struct UserListing: Identifiable{
    
    var id: String
}
/*
 struct UserListingDTO: Identifiable{
 
 var id: UUID
 
 init?(snapshot: DataSnapshot){
 guard let dict = snapshot.value as? [String: Any]
 else{
 return nil
 }
 id = dict.
 }
 
 //self.id = dict.first
 
 }
 */

struct ListingDTO {
    
    let id: String
    let title: String
    let services: String
    let bio: String
    let phone: String
    let email: String
    let city: String
    let state: String
    let radius: Int
    
    init?(snapshot: DataSnapshot){
        guard let dict = snapshot.value as? [String: Any],
              let title = dict["title"] as? String,
              let services = dict["services"] as? String,
              let bio = dict["bio"] as? String,
              let phone = dict["phone"] as? String,
              let email = dict["email"] as? String,
              let city = dict["city"] as? String,
              let state = dict["state"] as? String,
              let radius = dict["radius"] as? String
        else{
            return nil
        }
        
        self.id = snapshot.key
        
        //print("Listing ID: \(self.id)")
        
        self.title = title
        self.services = services
        self.bio = bio
        self.phone = phone
        self.email = email
        self.city = city
        self.state = state
        self.radius = Int(radius) ?? 0
    }
    
}
