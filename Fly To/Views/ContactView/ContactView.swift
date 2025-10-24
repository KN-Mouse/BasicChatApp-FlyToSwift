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
    
    @State var selectedUser: User? = nil
    
    var body: some View {
        NavigationStack {
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
                            .onTapGesture {
                                selectedUser = user
                            }
                            
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .navigationDestination(isPresented: Binding<Bool>(
                    get: { selectedUser != nil },
                    set: { if !$0 { selectedUser = nil }}
                )) {
                    if let user = selectedUser {
                        ChatRoomView(user: user)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContactView()
        .environmentObject(AuthViewModel())
}
