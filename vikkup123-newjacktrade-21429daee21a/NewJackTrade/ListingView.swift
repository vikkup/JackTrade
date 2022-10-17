//
//  ListingView.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 4/24/21.
//

import SwiftUI

struct ListingView: View {
    var listing: Listing
    @StateObject var viewModel = ListingViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                MapView(viewModel: viewModel)
                    .cornerRadius(25)
                    .frame(height: 300)
                    .disabled(true)
                
                HStack {
                    Text("Title:")
                    Spacer()
                    Text(listing.title)
                }.padding()
                
                HStack {
                    Text("Services:")
                    Spacer()
                    Text(listing.services)
                }.padding()
                
                HStack {
                    Text("Bio:")
                    Spacer()
                    Text(listing.bio)
                }.padding()
                HStack {
                    Text("Phone:")
                    Spacer()
                    Button(action: {
                        let formattedString = "tel://\(listing.phone)"
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    }) {
                        Text(listing.phone)
                    }
                }.padding()
                HStack {
                    Text("Email:")
                    Spacer()
                    Button(action: {
                        let formattedString = "mailto:\(listing.email)"
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    }) {
                        Text(listing.email)
                    }
                }.padding()
                Button("Save Listing"){
                    viewModel.saveListing(listingId: listing.id)
                }
            }.onAppear(){
                viewModel.getLocation(listing: listing)
            }
        }
    }
}
