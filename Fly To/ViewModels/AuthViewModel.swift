//
//  AuthViewModel.swift
//  Fly To
//
//  Created by Nguyen Khang on 16/10/25.
//

import Foundation
import FirebaseAuth
import Combine

enum authState {
    case loading
    case logOut
    case LogIn
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User? = nil
    @Published var authSatate: authState = .loading
    @Published var allUser: [User] = []
    
    private let manager = AuthManager()
    
    init() {
        Task {
            await self.loadUserSession()
            await self.fetchAllUser()
        }
    }
    
//    Check Login Session
    func loadUserSession() async {
        if let user = manager.loadSessionUser() {
            self.userSession = user
            do {
                self.currentUser = try await manager.fetchCurrentUser(userID: user.uid)
                self.authSatate = .LogIn
            } catch {
                print("Error fecthing user data")
            }
        }
        else {
            self.authSatate = .logOut
        }
    }
//    Signup
    func SignUp(email: String, password: String, userName: String) async {
        do {
            let (authUser, user) = try await manager.SignUp(userName: userName, email: email, password: password)
            
            self.userSession = authUser
            self.currentUser = user
            self.authSatate = .LogIn
        } catch {
            print("Error signing up")
        }
    }
//    Log in
    func LogIn(email: String, password: String) async {
        do {
            let (authUser, user) = try await manager.Login(email: email, password: password)
            self.userSession = authUser
            self.currentUser = user
            self.authSatate = .LogIn
        } catch {
            print("Error logging in")
        }
    }
//    Sign out
    func SignOut() async {
        self.authSatate = .logOut
        do {
            try manager.SigOut()
            self.userSession = nil
            self.currentUser = nil
            self.authSatate = .logOut
        } catch {
            print("Error signing out")
        }
    }
//    Fetch all user
    func fetchAllUser() async {
        do {
            let users = try await manager.fetchAllUser()
            DispatchQueue.main.async {
                self.allUser = users
            }
        } catch {
            print("Error fetching all user")
        }
    }
}
