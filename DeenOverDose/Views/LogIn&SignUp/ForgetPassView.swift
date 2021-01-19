//
//  ForgetPassView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-17.
//

import SwiftUI

struct ForgetPassView: View {
    
    @State var usernameEmail: String = ""
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var session: SessionStore
    
    @State var error: String = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 20.0)
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
                            .frame(width: geo.size.width / 20.0)
                        Text("Trouble logging in?")
                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 57.0))
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.45 : geo.size.width / 3.0)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width: geo.size.width / 8.0)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 8.0 : geo.size.height / 40.0)
                    Spacer()
                        .frame(height: geo.size.height / 8.0)
                    if (error != "" && error != "RESET") {
                        Text(error)
                            .fontWeight(.ultraLight)
                            .frame(width: geo.size.width / 1.1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                    } else if error == "RESET" {
                        Text("Password reset link has been sent successfully!")
                            .fontWeight(.ultraLight)
                            .frame(width: geo.size.width / 1.2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    } else {
                        Text("Enter your username or email and we'll send you a link to get back into your account.")
                            .fontWeight(.ultraLight)
                            .frame(width: geo.size.width / 1.2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    universalTF(text: $usernameEmail, placeHolder: "Username or email", geoHeight: geo.size.height, secure: false)
                        .padding(.top)
                        .padding(.bottom, 5)
                    Button(action: {
                        reset()
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
                    .disabled(usernameEmail.isEmpty)
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func reset() {
        session.forgotPassword(email: usernameEmail) { (error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.usernameEmail = ""
                self.error = "RESET"
            }
        }
    }
}

struct ForgetPassView_Previews: PreviewProvider {
    @State static var isActive: Bool = false
    
    static var previews: some View {
        ForgetPassView().environmentObject(SessionStore())
    }
}
