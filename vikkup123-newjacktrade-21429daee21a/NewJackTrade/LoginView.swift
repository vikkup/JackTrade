//
//  LoginView.swift
//  NewJackTrade
//
//  Created by Kevin Sampson on 4/6/21.
//

import SwiftUI

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        Home2()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home2 : View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if self.status {
                    
                    Homescreen()
                    
                }else {
                    
                    ZStack {
                        NavigationLink(destination: SigningUp(show: self.$show), isActive: self.$show) {
                            Text("")
                        }
                        .hidden()
                        
                        LoginView(show : self.$show)
                    }
                    
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName : NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct Homescreen : View {
    
    var body: some View {
        VStack {
            
            DashboardView()
            
            //            Button(action: {
            //
            //                try! Auth.auth().signOut()
            //                UserDefaults.standard.set(false, forKey: "status")
            //                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            //
            //            }) {
            //                Text("Log Out")
            //                    .foregroundColor(.white)
            //                    .padding(.vertical)
            //                    .frame(width: UIScreen.main.bounds.width - 100)
            //            }
            //            .background(Color("Color"))
            //            .cornerRadius(10)
            //            .padding(.top, 25)
        }
    }
}

struct LoginView : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack {
                        Image("LoginImage")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10, x: 20, y: 10)
                            .padding(.bottom)
                        
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack{
                                
                                if self.visible{
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                                else{
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.reset()
                                
                            }) {
                                Text("Forget pasword")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                        
                        Button(action: {
                            
                            self.verify()
                            
                        }) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal, 25)
                }
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                        .padding(.horizontal, 10)
                }
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func verify() {
        
        if self.email != "" && self.pass != "" {
            
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("Success")
                UserDefaults.standard.setValue(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    func reset() {
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "Reset"
                self.alert.toggle()
            }
        } else {
            
            self.error = "Email ID is Empty"
            self.alert.toggle()
        }
    }
}

struct SigningUp : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var name = ""
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .topLeading) {
                
                GeometryReader{_ in
                    
                    VStack {
                        Image("LoginImage")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10, x: 20, y: 10)
                            .padding(.bottom)
                        
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Name", text: self.$name)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack{
                                
                                if self.visible{
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                                else{
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack{
                                
                                if self.revisible{
                                    TextField("Re-enterPassword", text: self.$repass)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                                else{
                                    SecureField("Re-enter Password", text: self.$repass)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                            }
                            Button(action: {
                                self.revisible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            
                            self.register()
                            
                        }) {
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal, 25)
                }
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("Color"))
                }
                .padding()
            }
            
            if self.alert {
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func register() {
        if self.email != "" {
            if self.pass == self.repass {
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                    
                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    print("Success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
                
            } else {
                
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        } else {
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View {
        
        GeometryReader {_ in
            
            VStack {
                
                HStack {
                    
                    Text(self.error == "Reset" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "Reset" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(self.color)
                    //.padding(.top)
                    .padding(.horizontal, 25)
                
                Button(action : {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text(self.error == "Reset" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
