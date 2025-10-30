//
//  MessageManager.swift
//  Fly To
//
//  Created by Nguyen Khang on 22/10/25.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class MessageManager {
    
    static let shared = MessageManager()
    private let db = Firestore.firestore().collection("Conversation")
    
    init() {
        
    }
    
//    Send message
    func sendMessage(toUser user: User, message: String, completion: @escaping (Result<Void, Error>) -> Void){
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        let otherUserID = user.id
        
//        Create new Mess
        let currentRef = db.document(currentUserID).collection(otherUserID).document()
        let otherRef = db.document(otherUserID).collection(currentUserID)
        
//        Create recent Mess
        let reCurrentUserRef = db.document(currentUserID).collection("recentMess").document(otherUserID)
        let reOtheruserRef = db.document(otherUserID).collection("recentMess").document(currentUserID)
        
        let messID = currentRef.documentID
        
        let newMessage = Message(id: messID, fromID: currentUserID, toID: otherUserID, message: message, timestamp: Date())
        
        guard let messData = try? Firestore.Encoder().encode(newMessage) else { return }
        
        let batch = Firestore.firestore().batch()
//        new Mess
        batch.setData(messData, forDocument: currentRef)
        batch.setData(messData, forDocument: otherRef.document(messID))
        
//        Recent Mess
        
        batch.setData(messData, forDocument: reCurrentUserRef)
        batch.setData(messData, forDocument: reOtheruserRef)
        
        batch.commit { (error) in
            if let error = error {
                completion(.failure(error))
                print("Error send message (manager)")
            }else{
                completion(.success(()))
            }
        }
        
    }
//    Obsver all message
    func obseverMessage(otherUser: User, listener: @escaping (Result<[Message], Error>) -> Void){
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        let otherUserID = otherUser.id
        let messRef = db.document(currentUserID).collection(otherUserID).order(by: "timestamp", descending: false)
        
        messRef.addSnapshotListener { snapshot, error in
            if let error = error {
                listener(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents
            else {
                listener(.success([]))
                return }
            
            do {
                let mess = try documents.compactMap {
                    try $0.data(as: Message.self)
                }
//                messages
                listener(.success(mess))
            } catch {
                print("Fail to decode message")
            }
        }
        
    }
    
//    Obsever recent Mess
    func obseverRecentMess(completion: @escaping (Result<[Message], Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        let reMessRef = db.document(currentUserID).collection("recentMess").order(by: "timestamp", descending: true)
        
        reMessRef.addSnapshotListener { snap, error in
            if error != nil { return }
            
            guard let docs = snap?.documents
                    
            else {
                completion(.success([]))
                return
            }
            
            let mess: [Message] = docs.compactMap { doc in
                try? doc.data(as: Message.self)
            }
            
            completion(.success(mess))
        }
    }
    
}
