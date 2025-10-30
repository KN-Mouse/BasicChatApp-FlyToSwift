//
//  RecentMessageViewModel.swift
//  Fly To
//
//  Created by Nguyen Khang on 28/10/25.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine
import SwiftUI

@MainActor
class RecentMessageViewModel: ObservableObject {
    @Published var reMessage: [RecentMessage] = []
    
    let authManagaer = AuthManager()
    let manager = MessageManager.shared
    
    private var lastMessID: Set<String> = []
    private var isIntialLoad: Bool = true
    
    init() {
        loadRecentMessage()
    }
    
    func loadRecentMessage() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        manager.obseverRecentMess { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let message):
                let check = DispatchGroup()
                var messCheck: [RecentMessage] = []
                for mess in message {
                    check.enter()
                    
//                    fecth info otherUser
                    authManagaer.infoOtherUser(otherUserID: mess.otherUserID){ user in
                        let recent = RecentMessage(message: mess, user: user)
                        messCheck.append(recent)
                        
                        check.leave()
                    }
//                    fet data message and user -> [RecentMessage]
                }
                
                check.notify(queue: .main){
                    let sorted = messCheck.sorted {
                        $0.message.timestamp > $1.message.timestamp
                    }
                    
                    let newMess = sorted.filter{
                        !self.lastMessID.contains($0.message.id)
                    }
                    
                    self.lastMessID = Set(sorted.map { $0.message.id })
                    
                    withAnimation(.spring()){
                        self.reMessage = sorted
                    }
                }
                
            case .failure(let error):
                print("Can't load the recent message")
            }
        }
    }
}
