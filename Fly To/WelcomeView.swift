//
//  WelcomeView.swift
//  Fly To
//
//  Created by Nguyen Khang on 16/10/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct WelcomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch authVM.authSatate {
                case .loading:
                    ProgressView()
                case .LogIn:
                    MainView()
                case .logOut:
                    LogInView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AuthViewModel())
}
