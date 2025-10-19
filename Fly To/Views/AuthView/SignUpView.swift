//
//  SigUpView.swift
//  Fly To
//
//  Created by Nguyen Khang on 6/10/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var comfirmPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Fly To")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(Color.blue.opacity(0.6))
                .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 0)
                .shadow(color: .blue.opacity(0.4), radius: 8, x: 0, y: 0)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
            
            
            Group {
                InputField(placeholder: "Your name", text: $name, fill: .normal)
                InputField(placeholder: "Email", text: $email, fill:  .normal)
                InputField(placeholder: "Pass word", text: $password, fill: .password)
                InputField(placeholder: "Comfirm password", text: $comfirmPassword, fill: .password)
            }
            
            Button{
                Task {
                    await authVM.SignUp(email: email, password: password, userName: name)
                    dismiss()
                }
            } label: {
                Text("Sig Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
        }.padding(12)
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
