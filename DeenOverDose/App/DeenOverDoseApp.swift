//
//  DeenOverDoseApp.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FontAwesomeSwiftUI

@main
struct DeenOverDoseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        //Use Firebase Library to configure APIs
        FirebaseApp.configure()
        FontAwesome.register()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      
      if let error = error {
        print(error.localizedDescription)
        return
      }
        let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let currentUser = User(uid: (result?.user.uid)!, email: result?.user.email, username: result?.user.displayName)
            UserViewModel().saveUser(currentUser)
            
            NotificationCenter.default.post(name: NSNotification.Name("SIGNIN"), object: nil)
            
            print((result?.user.email)!)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
