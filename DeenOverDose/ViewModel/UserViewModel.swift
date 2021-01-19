//
//  UserViewModel.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-18.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    func saveUser(_ user: User) {
        do {
            _ = try db.collection("users").addDocument(from: user)
        } catch {
            fatalError("Unable to add the user - \(error.localizedDescription)")
        }
    }
}
