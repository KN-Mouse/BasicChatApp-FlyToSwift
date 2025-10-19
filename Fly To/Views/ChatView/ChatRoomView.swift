//
//  ChatRoomView.swift
//  Fly To
//
//  Created by Nguyen Khang on 14/10/25.
//

import SwiftUI

struct ChatRoomView: View {
    
    @State var text: String = ""
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
//                Chat with user
                
                ScrollView {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                        Text("User Name")
                    }
                    .padding(.bottom, 50)
                    
    //                Content messages
                    ForEach(0..<10){i in
                        HStack {
                            if i % 2 == 0 {
                                Spacer()
                                Text("Message")
                                    .font(.subheadline)
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .clipShape(MessageCellBubble(fromCurrentUser: true))
                                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                                
                            } else {
                                HStack {
                                    Image(systemName: "person")
                                    Text("Message")
                                        .font(.subheadline)
                                        .padding(12)
                                        .foregroundColor(.black)
                                        .background(.gray.opacity(0.2))
                                        .clipShape(MessageCellBubble(fromCurrentUser: false))
                                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                                    Spacer()
                                }
                            }
                        }
                      
                       
                    }
                }
                
//                Input Text
                
                Spacer()
                
                HStack {
                    TextField("Type", text: $text)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(20)
                    Button{
                        
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
    ChatRoomView()
}
