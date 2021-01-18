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
    @Binding var rootIsActive: Bool
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    @State var pageNumber: Int = 0
    
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
                            BackButton()
                        }
                        .opacity(pageNumber > 0 ? 0 : 1)
                        Spacer()
                            .frame(width: geo.size.width / 25.0)
                        Text(signUpPages[pageNumber].title)
                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 57.0))
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.5 : geo.size.width / 3.0)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width: geo.size.width / 8.0)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 8.0 : geo.size.height / 40.0)
                    Spacer()
                        .frame(height: geo.size.height / 5.0)
                    Text(signUpPages[pageNumber].subtext)
                        .frame(width: geo.size.width / 1.1)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    ZStack {
                        universalTF(text: $email, placeHolder: "Email Address", geoHeight: geo.size.height, secure: false)
                            .padding(.top)
                            .padding(.bottom, 5)
                            .opacity(pageNumber == 0 ? 1 : 0)
                        universalTF(text: $username, placeHolder: "Username", geoHeight: geo.size.height, secure: false)
                            .padding(.top)
                            .padding(.bottom, 5)
                            .opacity(pageNumber == 1 ? 1 : 0)
                        universalTF(text: $password, placeHolder: "Password", geoHeight: geo.size.height, secure: false)
                            .padding(.top)
                            .padding(.bottom, 5)
                            .opacity(pageNumber == 2 ? 1 : 0)
                    }
                    Button(action: {
                        if pageNumber < 2 {
                            pageNumber += 1
                        } else {
                            dismiss()
                            print("email: \(email)")
                            print("username: \(username)")
                            print("password: \(password)")
                            
                        }
                        
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
                    .disabled(pageNumber == 0 ? email.isEmpty : (pageNumber == 1 ? username.isEmpty : password.isEmpty))
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func dismiss() {
        withAnimation {
            isOBShowing.toggle()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var isActive: Bool = false
    
    static var previews: some View {
        SignUpView(isOBShowing: Binding.constant(true), rootIsActive: $isActive)
    }
}
