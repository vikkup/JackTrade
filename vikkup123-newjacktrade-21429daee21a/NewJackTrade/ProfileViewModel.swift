//
//  ProfileViewModel.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 4/13/21.
//

import Foundation
import Firebase
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var profile: Profile
    @Published var listings = [Listing]()
    var userListings = [UserListing]()
    
    init() {
        profile = Profile(userid:"",name:"",email:"")
        if let user = Auth.auth().currentUser {
            profile.userid = user.uid
            profile.name = user.displayName ?? ""
            profile.email = user.email ?? ""
        }
        fetchListings()
    }
    
    func fetchListings(){
        
        let databaseRef = Database.database().reference(withPath: "userlistings/\(self.profile.userid)")//.queryOrdered(byChild: "email")
        
        databaseRef.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let job = snapshotValue["job"]!
            self.userListings.append(UserListing(id: job))
            
            let ref = Database.database().reference(withPath: "users")
            
            ref.observe(.value, with: { snapshot in
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let listingDTO = ListingDTO(snapshot: snapshot){
                        let listing = Listing(id: listingDTO.id, title: listingDTO.title, services: listingDTO.services, bio: listingDTO.bio, phone: listingDTO.phone, email: listingDTO.email, city: listingDTO.city, state: listingDTO.state, radius: listingDTO.radius)
                        print("**** \(listing.id)")
                        if (listing.id == job) {
                            self.listings.append(listing)
                            print("######  \(self.listings.count)")
                        }
                    }
                }
            })
        }
    }
    
    func savePassword(currentPwd: String, newPwd: String, cfmPwd: String){
        
        if newPwd == cfmPwd  {
            Auth.auth().signIn(withEmail: self.profile.email, password: currentPwd) { (res, err) in
                if err != nil {
                    print("error  \(err!.localizedDescription)")
                }
                print("Success Success")
            }
            
            Auth.auth().currentUser?.updatePassword(to: newPwd) { (error) in
                print("Error \(String(describing: error))")
            }
        }
    }
    
}
