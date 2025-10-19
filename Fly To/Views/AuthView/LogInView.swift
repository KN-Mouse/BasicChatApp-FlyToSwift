//
//  LogInView.swift
//  Fly To
//
//  Created by Nguyen Khang on 2/10/25.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Fly To")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color.blue.opacity(0.6))
                    .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 0)
                    .shadow(color: .blue.opacity(0.4), radius: 8, x: 0, y: 0)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                
                Spacer()
                
    //            Input
                InputField(placeholder: "Email", text: $email, fill: .normal)
                InputField(placeholder: "Pass word", text: $password, fill: .password)
              
                Button {
                    Task {
                        await authVM.LogIn(email: email, password: password)
                    }
                } label: {
                    Text("Login")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
                
    //            To Signup View
                
                NavigationLink(destination: SignUpView()){
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .padding(.top, 30)
                }
                
                Spacer()
                
                
            }
            .padding()
        }

    }
}

#Preview {
    LogInView()
        .environmentObject(AuthViewModel())
}
