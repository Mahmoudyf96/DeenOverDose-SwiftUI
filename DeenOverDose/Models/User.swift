//
//  User.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-18.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    
    @DocumentID var id: String?
    var uid: String
    var email: String?
    var username: String?
    
    enum CodingKeys: CodingKey {
        case uid
        case email
        case username
    }
}
