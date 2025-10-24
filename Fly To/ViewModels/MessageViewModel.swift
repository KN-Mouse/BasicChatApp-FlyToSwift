//
//  MessageViewModel.swift
//  Fly To
//
//  Created by Nguyen Khang on 22/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var text: String = ""
    
    private let messageManager = MessageManager.shared
    private let user: User
    
    init(user: User){
        self.user = user
        observeMessages()
    }
    
//    obsever message
    func observeMessages(){
        messageManager.obseverMessage(otherUser: user) { result in
            switch result {
            case .success(let mess):
                self.messages = mess
                print("mess\(mess)")
            case .failure(_):
                print("Error to fecth message")
            }
        }
    }
//    send message
    func sendMessage(){
        let trimed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimed.isEmpty else { return }
        
        messageManager.sendMessage(toUser: user, message: trimed){ [weak self] result in
            switch result {
            case .success:
                self?.text = ""
            case .failure(let error):
                print("Fail to send message: \(error)")
            }
            
        }
    }
}
