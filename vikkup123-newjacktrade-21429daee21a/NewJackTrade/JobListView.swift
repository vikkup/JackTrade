//
//  JobListView.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 3/14/21.
//

import Foundation
import SwiftUI

struct JobListView: View {
    
    @ObservedObject private var model = JobListingViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                Form {
                    TextField("Job Listing Title: ", text: $model.listing.title)
                    TextField("Services Offered: ", text: $model.listing.services)
                    TextField("Bio: ", text: $model.listing.bio)
                    TextField("Service Radius: ", value: $model.listing.radius, formatter: NumberFormatter())
                    TextField("Phone Number: ", text: $model.listing.phone)
                    TextField("Email: ", text: $model.listing.email).autocapitalization(.none)
                    TextField("City: ", text: $model.listing.city).autocapitalization(.words)
                    TextField("State: ", text: $model.listing.state).autocapitalization(.allCharacters)
                    HStack{
                        Spacer()
                        //Button("Add your location") {
                        //MapView()
                        // }
                        //  Spacer()
                    }
                    HStack{
                        Spacer()
                        Button("Submit Listing") {
                            model.saveListing()
                        }
                        Spacer()
                    }
                    
                }.navigationBarTitle("Job Listing Form")
            }
            
        }
    }
}
