//
//  Message.swift
//  Fly To
//
//  Created by Nguyen Khang on 22/10/25.
//

import Foundation
import FirebaseAuth

struct Message: Identifiable, Codable, Hashable {
    var id: String = NSUUID().uuidString
    var fromID: String
    var toID: String
    var message: String
    var timestamp: Date
    
    var fromCurrentUser: Bool {
        return fromID == Auth.auth().currentUser?.uid
    }
    
    var otherUserID: String {
        return fromID == Auth.auth().currentUser?.uid ? toID : fromID
    }
    
    var user: User?
}
