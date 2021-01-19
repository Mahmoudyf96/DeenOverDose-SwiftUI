//
//  OnBoardingView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-12.
//

import SwiftUI
import GoogleSignIn
import Firebase
import FontAwesomeSwiftUI
import AuthenticationServices

let slides = [
    OnBoardingPages(title: "Welcome", message: "Sign Up for 100% free priceless knowledge offered by deen over dunyah."),
    OnBoardingPages(title: "Stories", message: "Learn the true and beautiful teachings of islam in the palm of your hands."),
    OnBoardingPages(title: "Quizzes", message: "Single and Multiplayer trivia on the basics of islamic knowledge and muslim belief.")
]

struct OnBoardingPages {
    let title: String
    let message: String
}

struct OnBoardingView: View {
    
    @State var logInIsActive: Bool = false
    
    @Binding var isOBShowing: Bool
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selection = 0
    
    @State var user = Auth.auth().currentUser
    @State var appleAuth = SignInWithApple()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Background()
                    VStack {
                        Image("DeenOD")
                            .resizable()
                            .scaledToFit()
                            .frame(width: sizeClass == .compact ? geo.size.width / 12.0 : geo.size.width / 18.0)
                            .padding()
                        Image("peaceScreen")
                            .resizable()
                            .scaledToFit()
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.2 : geo.size.width / 1.8)
                            .padding(.bottom)
                            .padding(.bottom)
                        TabView(selection: $selection) {
                            ForEach(slides.indices, id: \.self) { index in
                                VStack {
                                    Text(slides[index].title)
                                        .font(.custom("Bungee-Inline", size: sizeClass == .compact ? geo.size.height / 27.0 : geo.size.height / 20.0))
                                        .foregroundColor(.white)
                                        .padding()
                                    Text(slides[index].message)
                                        .font(.custom("Bungee-Regular", size: sizeClass == .compact ? geo.size.height / 57.0 : geo.size.height / 40.0))
                                        .lineSpacing(10.0)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.05 : geo.size.width / 1.1)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                                .offset(y: sizeClass == .compact ? -geo.size.height / 25.0 : -geo.size.height / 55.0)
                                .padding(.vertical)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle( ))
                        .frame(height: geo.size.height / 4.0)
                        NavigationLink(destination: SignUpView(isOBShowing: $isOBShowing)) {
                            ZStack {
                                Image("mediumButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: sizeClass == .compact ? geo.size.width / 1.12 : geo.size.width / 1.2)
                                Text("SIGN UP FREE")
                                    .font(.custom("PressStart2P-Regular", size: geo.size.height / 65.0))
                                    .foregroundColor(.black)
                            }
                        }
                        .isDetailLink(false)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            if (user?.email)! != "" {
                                print((user?.email)!)
                                dismiss()
                            } else {
                                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                                GIDSignIn.sharedInstance()?.signIn()
                                if (user?.email)! != "" {
                                    print((user?.email)!)
                                    dismiss()
                                }
                            }
                        }) {
                            ZStack {
                                Image("blackMButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: sizeClass == .compact ? geo.size.width / 1.12 : geo.size.width / 1.2)
                                HStack (spacing: 10) {
                                    Text(AwesomeIcon.google.rawValue)
                                        .font(.awesome(style: .brand, size: geo.size.height / 33.0))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                    Text("CONTINUE WITH GOOGLE")
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 65.0))
                                        .foregroundColor(.white)
                                        .padding(.top, 2)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                        Button(action: {
                            if (user?.email)! != "" {
                                print((user?.email)!)
                                dismiss()
                            } else {
                                appleAuth.startSignInWithAppleFlow()
                                if (user?.email)! != "" {
                                    print((user?.email)!)
                                    dismiss()
                                }
                            }
                        }) {
                            ZStack {
                                Image("blackMButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: sizeClass == .compact ? geo.size.width / 1.12 : geo.size.width / 1.2)
                                HStack (spacing: 10) {
                                    Text(AwesomeIcon.apple.rawValue)
                                        .font(.awesome(style: .brand, size: geo.size.height / 28.0))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 2)
                                    Text("CONTINUE WITH APPLE")
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 65.0))
                                        .foregroundColor(.white)
                                        .padding(.top, 2)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                        NavigationLink(destination: LogInView(isOBShowing: $isOBShowing, rootIsActive: $logInIsActive), isActive: $logInIsActive) {
                            Text("LOG IN")
                                .font(.custom("PressStart2P-Regular", size: geo.size.height / 65.0))
                                .foregroundColor(.white)
                                .padding()
                                .padding(.bottom)
                        }
                        .isDetailLink(false)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
                self.user = Auth.auth().currentUser
            }
        }
    }
    
    func dismiss() {
        withAnimation {
            isOBShowing.toggle()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(isOBShowing: Binding.constant(true))
    }
}
