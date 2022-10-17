//
//  SearchView.swift
//  JackTrade
//
//  Created by Vikku Ponnaganti on 2/16/21.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var model = SearchViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    Image(systemName:
                            "magnifyingglass").foregroundColor(
                                .secondary).padding(.leading,10)
                    TextField("Search for a provider", text:
                                $model.search)
                        .disableAutocorrection(true)
                        .padding(.trailing,10)
                }.padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                /*
                 Button("Search") {
                 print("Search for:  \(search)")
                 
                 model.find(value: search)
                 
                 hideKeyboard()
                 }
                 */
                Spacer()
                
                List(model.searchResults) { listing in
                    NavigationLink(
                        destination: ListingView(listing: listing)){
                        VStack {
                            Text(listing.title)
                                .padding()
                            Text(listing.services)
                                .padding()
                            Text(listing.bio)
                        }
                    }
                }
                Spacer()
                
                HStack{
                    Spacer()
                    NavigationLink(destination: JobListView()) {
                        Text("+")
                            .frame(minWidth: 0, maxWidth: 40, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.init("TabColor"), Color.init("TabColor")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(25)
                            .font(.largeTitle)
                        
                    }
                    
                }.padding(10)
            }
        }.onAppear(perform: {
            model.fetchListings()
        })
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder
                                            .resignFirstResponder), to:nil, from: nil, for: nil)
    }
}
#endif
