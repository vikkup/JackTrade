//
//  ProfileView.swift
//  JackTrade
//
//  Created by Vikku Ponnaganti on 2/16/21.
//

import Foundation
import SwiftUI
import Firebase

struct ProfileView: View{
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                CircleImage()
                Spacer()
                Text("User Id:  \(profileViewModel.profile.email)")
                NavigationLink(destination: ChangePasswordView(profileViewModel: profileViewModel)) {
                    Text("Change Password")
                }
                Spacer()
                
                List(profileViewModel.listings) { listing in
                    NavigationLink(
                        destination: ListingView(listing: listing)){
                        HStack {
                            Text(listing.title)
                                .padding()
                            Text(listing.services)
                                .padding()
                            Text(listing.bio)
                        }
                    }
                }
                
                Button(action: {
                    
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .navigationBarTitle("Your Profile")
        }
    }
    
}

struct CircleImage: View {
    var body: some View {
        Image("vikkuImg")
            .resizable()
            .frame(width: 200, height: 200)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
    }
}

struct ChangePasswordView: View {
    @ObservedObject var profileViewModel:ProfileViewModel
    
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        Form{
            SecureField("Current Password", text: $oldPassword)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            SecureField("New Password", text: $newPassword)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            
            Spacer()
            
            Button(action: {
                profileViewModel.savePassword(currentPwd: oldPassword, newPwd: newPassword, cfmPwd: confirmPassword)
            }) {
                Text("Save Changes")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}



/*
 struct ProfileView: View {
 
 let profileLinkNames: [String] = ["Name", "Email", "Password"]
 
 @Environment(\.editMode) var editMode
 
 var body: some View {
 NavigationView {
 VStack {
 VStack{
 HStack {
 Spacer()
 EditButton()
 }
 
 CircleImage().offset(y: -130).padding(.bottom, -130)
 }.padding()
 
 //Spacer()
 
 VStack(alignment: .leading){
 Text("Vikku Ponnaganti")
 .font(.title)
 HStack() {
 Text("Computer Expert")
 .font(.subheadline)
 Spacer()
 Text("Computer Science")
 }
 }.padding()
 
 Button(action: {
 
 try! Auth.auth().signOut()
 UserDefaults.standard.set(false, forKey: "status")
 NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
 
 }) {
 Text("Log Out")
 .foregroundColor(.white)
 .padding(.vertical)
 .frame(width: UIScreen.main.bounds.width - 100)
 }
 .background(Color("Color"))
 .cornerRadius(10)
 .padding(.top, 25)
 
 }.edgesIgnoringSafeArea(.top)
 }.navigationBarTitle("Vikku Ponnaganti")
 }
 }
 */
