//
//  AuthManager.swift
//  Fly To
//
//  Created by Nguyen Khang on 15/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
class AuthManager {
    
    static let shared = AuthManager()
    private let fireStore = Firestore.firestore()
    
//    Loading Session User Login
    func loadSessionUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
//    Get current User
    func fetchCurrentUser(userID: String) async throws -> User {
        let snap = try await fireStore.collection("User").document(userID).getDocument()
        return try snap.data(as: User.self)
    }
//    SignUp
    func SignUp(userName: String, email: String, password: String) async throws -> (authUser: FirebaseAuth.User, userData: User){
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let newUser = User(id: result.user.uid, username: userName, email: email)
        
        try fireStore.collection("User").document(result.user.uid).setData(from: newUser)
        return (result.user, newUser)
    }
//    Login
    func Login(email: String, password: String) async throws -> (authUser: FirebaseAuth.User, userData: User){
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        let userData = try await fetchCurrentUser(userID: result.user.uid)
        
        return (result.user, userData)
    }
//    SignOut
    func SigOut() throws {
        try Auth.auth().signOut()
    }
//    Fetch all User
    func fetchAllUser() async throws -> [User] {
        let snapshot = try await fireStore.collection("User").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
//    fect info other User
    func infoOtherUser(otherUserID: String, completion: @escaping(User) -> Void) {
        fireStore.collection("User").document(otherUserID).getDocument() { snap, error in
            Task { @MainActor in
                guard let user = try? snap?.data(as: User.self) else { return }
                completion(user)

            }
        }
    }
}
