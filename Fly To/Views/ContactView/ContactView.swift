//
//  ContactView.swift
//  Fly To
//
//  Created by Nguyen Khang on 13/10/25.
//

import SwiftUI

struct ContactView: View {
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
                ForEach(0..<30){i in
                    HStack{
                        Image(systemName: "person")
                        Text("User name")
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
}
