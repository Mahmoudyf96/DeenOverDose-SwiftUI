//
//  LogInView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-16.
//

import SwiftUI

struct PlaceHolder: ViewModifier {
    
    @State var geoHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("PressStart2P-Regular", size: geoHeight / 60.0))
            .foregroundColor(Color(#colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)))
            .padding(.horizontal)
            .disableAutocorrection(true)
            .frame(height: geoHeight / 15.0)
            .overlay(RoundedRectangle(cornerRadius: 5.0).stroke(Color(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)), lineWidth: 1.5))
            .padding(.horizontal)
    }
}

extension View {
    func PlaceHolderStyle(geoHeight: CGFloat) -> some View {
        self.modifier(PlaceHolder(geoHeight: geoHeight))
    }
}

struct universalTF: View {
    
    @Binding var text: String
    @State var placeHolder: String
    
    @State var geoHeight: CGFloat
    
    @State var secure: Bool
    
    var body: some View {
        if secure {
            SecureField(placeHolder, text: $text)
                .PlaceHolderStyle(geoHeight: geoHeight)
        } else {
            TextField(placeHolder, text: $text)
                .PlaceHolderStyle(geoHeight: geoHeight)
        }
    }
}

struct LogInView: View {
    @Binding var isOBShowing: Bool
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var rootIsActive: Bool
    
    @State var username: String = ""
    @State var password: String = ""
    
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
                            BackButton()
                        }
                        Spacer()
                            .frame(width: geo.size.width / 4.8)
                        Text("Log In")
                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 48.0))
                            .frame(width: sizeClass == .compact ? geo.size.width / 3.4 : geo.size.width / 5.0)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 8.0 : geo.size.height / 40.0)
                    Spacer()
                        .frame(height: geo.size.height / 5.0)
                    universalTF(text: $username, placeHolder: "Username", geoHeight: geo.size.height, secure: false)
                        .padding(.top)
                        .padding(.bottom, 5)
                    universalTF(text: $password, placeHolder: "Password", geoHeight: geo.size.height, secure: true)
                    NavigationLink(destination: ForgetPassView(rootIsActive: $rootIsActive)) {
                        Text("Forgot password?")
                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 68.0))
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width / 1.1, alignment: .trailing)
                            .padding(5)
                    }
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50.0, style: .continuous)
                                .frame(width: geo.size.width / 3.0, height: geo.size.height / 15.0)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.4235294118, blue: 0.2078431373, alpha: 1)))
                            Text("LOG IN")
                                .font(.custom("PressStart2P-Regular", size: geo.size.height / 65.0))
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                    }
                    .disabled(username.isEmpty || password.isEmpty)
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

struct LogInView_Previews: PreviewProvider {
    @State static var isActive: Bool = false
    
    static var previews: some View {
        LogInView(isOBShowing: Binding.constant(true), rootIsActive: $isActive)
    }
}
