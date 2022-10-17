//
//  SearchViewModel.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 3/15/21.
//

import Foundation
import Firebase
import Combine

class SearchViewModel: ObservableObject {
    
    var listings = [Listing]()
    @Published var searchResults = [Listing]()
    @Published var search: String = ""
    
    var userId: String = ""
    
    private var disposables = Set<AnyCancellable>()
    
    init( scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ){
        $search
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: find(search:)
            )
            .store(in: &disposables)
        
        let user = Auth.auth().currentUser
        if let userId = user?.uid  {
            self.userId = userId
        }
    }
    
    func fetchListings(){
        
        let ref = Database.database().reference(withPath: "users")
        
        ref.observe(.value, with: { snapshot in
            self.listings.removeAll()
            self.searchResults.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let listingDTO = ListingDTO(snapshot: snapshot){
                    let listing = Listing(id: listingDTO.id, title: listingDTO.title, services: listingDTO.services, bio: listingDTO.bio, phone: listingDTO.phone, email: listingDTO.email, city: listingDTO.city, state: listingDTO.state, radius: listingDTO.radius)
                    self.listings.append(listing)
                    if listing.id != self.userId{
                        self.searchResults.append(listing)
                    }
                }
            }
        })
    }
    
    func find(search value: String)
    {
        searchResults = [Listing]()
        for (_, listing) in listings.enumerated()
        {
            print(listing.title)
            if listing.title == value && listing.id != userId{
                searchResults.append(listing)
            }
        }
    }
}
