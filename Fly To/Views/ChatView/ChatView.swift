//
//  ChatView.swift
//  Fly To
//
//  Created by Nguyen Khang on 13/10/25.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack {
//            Ìnor
            HStack {
                Text("Fly To")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color.blue.opacity(0.6))
                    .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 0)
                    .shadow(color: .blue.opacity(0.4), radius: 8, x: 0, y: 0)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                
                Spacer()
                Image(systemName: "person")
            }
            
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0..<5){ i in
                            VStack {
                                Image(systemName: "person")
                                Text("User Name")
                            }
                            .padding()
                        }
                    }
                }
                
                
                ForEach(0..<20){_ in
                    HStack{
                        Image(systemName: "person")
                        Text("Message Content")
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ChatView()
}
