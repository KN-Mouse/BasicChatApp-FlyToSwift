//
//  Fly_ToApp.swift
//  Fly To
//
//  Created by Nguyen Khang on 2/10/25.
//

import SwiftUI

@main
struct Fly_ToApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(authVM)
        }
    }
}
