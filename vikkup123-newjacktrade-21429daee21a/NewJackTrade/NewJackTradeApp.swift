//
//  NewJackTradeApp.swift
//  NewJackTrade
//
//  Created by Vikku Ponnaganti on 3/8/21.
//

import SwiftUI
import Firebase

@main
struct NewJackTradeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

