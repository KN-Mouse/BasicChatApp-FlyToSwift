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
        
        let currentRef = db.document(currentUserID).collection(otherUserID).document()
        let otherRef = db.document(otherUserID).collection(currentUserID)
        
        let messID = currentRef.documentID
        
        let newMessage = Message(id: messID, fromID: currentUserID, toID: otherUserID, message: message, timestamp: Date())
        
        guard let messData = try? Firestore.Encoder().encode(newMessage) else { return }
        
        let batch = Firestore.firestore().batch()
        batch.setData(messData, forDocument: currentRef)
        batch.setData(messData, forDocument: otherRef.document(messID))
        
        batch.commit { (error) in
            if let error = error {
                completion(.failure(error))
                print("Error send message (manager)")
            }else{
                completion(.success(()))
            }
        }
        
    }
//    obsever message
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
    
}
