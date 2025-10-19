//
//  User.swift
//  Fly To
//
//  Created by Nguyen Khang on 15/10/25.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String
    var username: String
    var email: String
    
    init(id: String, username: String, email: String) {
        self.id = id
        self.username = username
        self.email = email
    }
}

extension User {
    static let mockUser =  User(id: "1", username: "MockUser", email: "mock@gmail.com")
}
