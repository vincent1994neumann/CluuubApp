//
//  ChatSenderViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 17.04.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatSenderViewModel : ObservableObject {
    
    @Published var currentUser : Rower?
    @Published var messages: [Message] = []

    //Search for Rower
    @Published var allUsers: [Rower] = []
    @Published var searchForRower = ""
    
   
    @Published var filterUsers: [Rower] = []

    init() {
        loadCurrentUser()   
    }
    
    
    
    func sendMessage(text: String, recipientId: String){
        guard let currentUser = currentUser else { return }
        
        let message = Message(
            text: text,
            senderId: currentUser.id,
            recipientId: recipientId,
            timestamp: Date()
        )
        let chatId = generateChatId(with: recipientId)
        
        do {
                try FirebaseManager.shared.fireStore.collection("chats").document(chatId)
                    .collection("messages").addDocument(from: message) { error in
                        if let error = error {
                            print("Error sending message: \(error)")
                            return
                        }
                    }
            } catch let error {
                print("Error sending message: \(error)")
            }
    }
    
    private func generateChatId(with otherUserId: String) -> String {
        guard let currentUserId = self.currentUser?.id else {
            fatalError("Current user id is not set")
        }
        // Sortieren Sie die IDs, damit die Reihenfolge immer konstant ist, unabhängig davon,
        // wer der Sender oder der Empfänger ist. Dadurch wird sichergestellt, dass beide
        // Benutzer dieselbe Chat-ID verwenden, wenn sie miteinander interagieren.
        let ids = [currentUserId, otherUserId].sorted()
        // Verbinden Sie die sortierten IDs zu einer einzigen Zeichenkette, die als Chat-ID dient.
        let chatId = ids.joined(separator: "_")
        return chatId
    }

    
    func fetchMessages(with recipientId: String) {
        let chatId = generateChatId(with: recipientId)
        FirebaseManager.shared.fireStore.collection("chats").document(chatId)
            .collection("messages").order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching messages: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                self?.messages = documents.compactMap { document -> Message? in
                    try? document.data(as: Message.self)
                }
            }
    }

    
    
    
    
    
    func loadCurrentUser() {
          guard let uid = Auth.auth().currentUser?.uid else { return }

          FirebaseManager.shared.fireStore.collection("user")
              .document(uid)
              .getDocument { [weak self] documentSnapshot, error in
                  if let error = error {
                      print("Error loading user: \(error)")
                      return
                  }
                  guard let documentSnapshot = documentSnapshot else { return }
                  self?.currentUser = try? documentSnapshot.data(as: Rower.self)
              }
      }
    
    
    func fetchAllUsers() {
           FirebaseManager.shared.fireStore.collection("user")  // Stellen Sie sicher, dass der Collection-Name korrekt ist!
               .getDocuments { [weak self] (querySnapshot, error) in
                   if let error = error {
                       print("Error getting user: \(error)")
                       return
                   }
                   self?.allUsers = querySnapshot?.documents.compactMap { document in
                       try? document.data(as: Rower.self)
                   } ?? []
                   self?.filterUsers = self?.allUsers ?? []
               }
       }

       func filterUsers(with searchText: String) {
           if searchText.isEmpty {
               filterUsers = allUsers
           } else {
               filterUsers = allUsers.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) }
           }
       }
   }
