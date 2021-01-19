//
//  SignUpView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-16.
//

import SwiftUI

let signUpPages = [
    SignUpPage(title: "Enter your Email", subtext: "Add your email so we can update you on our weekly prizes."),
    SignUpPage(title: "Add your Username", subtext: "Add your username so your friends can find you."),
    SignUpPage(title: "Create a Password", subtext: "")
]

struct SignUpPage {
    @State var title: String
    @State var subtext: String
}

struct SignUpView: View {
    @Binding var isOBShowing: Bool
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    @EnvironmentObject var session: SessionStore
    @StateObject var user = UserViewModel()
    
    @State var isHeroPageActive: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 35.0)
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: sizeClass == .compact ? 25 : 70, height: sizeClass == .compact ? 25 : 70)
                                .foregroundColor(.white)
                        }
                        Spacer()
                            .frame(width: geo.size.width / 25.0)
                        Text("Create Account")
                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 45.0))
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.5 : geo.size.width / 3.0)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width: geo.size.width / 8.0)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 8.0 : geo.size.height / 40.0)
                    Spacer()
                        .frame(height: geo.size.height / 8.0)
                    if (error != "") {
                        Text(error)
                            .fontWeight(.ultraLight)
                            .frame(width: geo.size.width / 1.1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                    } else {
                        Text(email.isEmpty ? signUpPages[0].subtext : (username.isEmpty ? signUpPages[1].subtext : signUpPages[2].subtext))
                            .fontWeight(.ultraLight)
                            .frame(width: geo.size.width / 1.1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    VStack {
                        universalTF(text: $email, placeHolder: "Email Address", geoHeight: geo.size.height, secure: false)
                            .padding(.top)
                        universalTF(text: $username, placeHolder: "Username", geoHeight: geo.size.height, secure: false)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                        universalTF(text: $password, placeHolder: "Password", geoHeight: geo.size.height, secure: true)
                            .padding(.bottom, 5)
                    }
                    NavigationLink(destination: StarterHeroesView(isOBShowing: $isOBShowing), isActive: $isHeroPageActive) {
                        Button(action: {
                            signUp()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7.0, style: .continuous)
                                    .frame(width: geo.size.width / 1.1, height: geo.size.height / 14.0)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.4235294118, blue: 0.2078431373, alpha: 1)))
                                Text("Next")
                                    .font(.custom("PressStart2P-Regular", size: geo.size.height / 65.0))
                                    .foregroundColor(.white)
                            }
                            .padding(.top)
                        }
                    }
                    .disabled(email.isEmpty && username.isEmpty && password.isEmpty)
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                guard let uid = result?.user.uid else { return }
                let currentUser = User(uid: uid, email: email, username: username)
                user.saveUser(currentUser)
                self.email = ""
                self.password = ""
                isHeroPageActive = true
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignUpView(isOBShowing: Binding.constant(true)).environmentObject(SessionStore())
    }
}
