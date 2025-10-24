//
//  ChatRoomView.swift
//  Fly To
//
//  Created by Nguyen Khang on 14/10/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ChatRoomView: View {
    
    @StateObject var MessVM: MessageViewModel
    
    let user: User
    
    init(user: User){
        self.user = user
        _MessVM = StateObject(wrappedValue: MessageViewModel(user: user))
    }
    

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
//                Chat with user
                
                ScrollView {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                        Text(user.username)
                    }
                    .padding(.bottom, 50)
                    
    //                Content messages
                    ForEach(MessVM.messages){mess in
                        HStack {
                            if mess.fromCurrentUser {
                                Spacer()
                                Text(mess.message)
                                    .font(.subheadline)
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .clipShape(MessageCellBubble(fromCurrentUser: mess.fromCurrentUser))
                                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                                
                            } else {
                                HStack(alignment: .bottom, spacing: 8) {
                                    Image(systemName: "person")
                                    Text(mess.message)
                                        .font(.subheadline)
                                        .padding(12)
                                        .foregroundColor(.black)
                                        .background(.gray.opacity(0.2))
                                        .clipShape(MessageCellBubble(fromCurrentUser: mess.fromCurrentUser))
                                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                                }
                                
                                Spacer()
                            }
                        }
                        .id(mess.id)
                        .padding(.bottom, 6)
                        .padding(.horizontal, 8)
                        
                      
                       
                    }
                }
                .onChange(of: MessVM.messages.count){
                    if let last = MessVM.messages.last {
                        withAnimation{
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
                
//                Input Text
                
                Spacer()
                
                HStack {
                    TextField("Type", text: $MessVM.text)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(20)
                    Button{
                        MessVM.sendMessage()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.system(size: 30))
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
        }
        .padding()
    }
}

#Preview {
    ChatRoomView(user: User.mockUser)
}
