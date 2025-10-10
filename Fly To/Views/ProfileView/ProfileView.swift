//
//  ProfileView.swift
//  Fly To
//
//  Created by Nguyen Khang on 9/10/25.
//

import SwiftUI

struct ProfileView: View {
    
    let coverHieght = UIScreen.main.bounds.height * 0.5
    
    var body: some View {
        ScrollView {
            ZStack {
//                Cover
                VStack {
                    
                    Color.gray
                        .frame(height: coverHieght / 2)
                    
                    Spacer()
                }
                
                VStack {
                    HStack() {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .frame(width: 100, height: 100)
                            
                            Text("Loading user Name")
                                .font(.title3
                                )
                        }
                        
                        Spacer()
                        
                        Image(systemName: "camera.shutter.button")
                    }
                    .padding(.top, coverHieght / 12)
                    
                    HStack {
                        Text("Some infomation here")
                        
                        Spacer()
                        
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                }
                .padding(.horizontal)


            }
            .frame(maxWidth: .infinity)
            .frame(height: coverHieght)
          
            //                 news or status
            VStack {
                ForEach(0..<30){ i in
                Text("Newthing here \(i)")
                        .padding()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
