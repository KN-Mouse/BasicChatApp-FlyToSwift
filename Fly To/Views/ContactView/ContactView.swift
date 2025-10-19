//
//  ContactView.swift
//  Fly To
//
//  Created by Nguyen Khang on 13/10/25.
//

import SwiftUI

struct ContactView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State var text: String = ""
    var body: some View {
        VStack {
            TextField("Search to...", text: $text)
                .padding()
                .background(.gray.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .cornerRadius(25)
            
            List {
                ForEach(authVM.allUser){user in
                    if user.username != authVM.currentUser?.username{
                        HStack{
                            Image(systemName: "person")
                            Text(user.username)
                        }

                    }
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    ContactView()
        .environmentObject(AuthViewModel())
}
