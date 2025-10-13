//
//  ContentView.swift
//  Fly To
//
//  Created by Nguyen Khang on 2/10/25.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedtab = 0
    var body: some View {
        TabView(selection: $selectedtab){
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                }
                .tag(0)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
                .tag(1)
            
            ContactView()
                .tabItem {
                    Image(systemName: "rectangle.stack.badge.person.crop.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainView()
}
