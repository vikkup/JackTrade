//
//  Dashboard.swift
//  JackTrade
//
//  Created by Vikku Ponnaganti on 2/16/21.
//

import SwiftUI
import Firebase

struct DashboardView: View {
    @State var selectedView = 1
    
    var body: some View {
        TabView(selection: $selectedView) {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "doc.text.magnifyingglass")
                }
                /*
                 .tag(1)
                 MapView()
                 .tabItem {
                 Label("Map", systemImage: "mappin.and.ellipse")
                 }
                 */
                .tag(2)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage:
                            "person")
                }
                .tag(3)
            
        }
        .accentColor(.init("TabColor"))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
