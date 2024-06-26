//
//  PinnwandViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 01.04.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class PinnwandViewModel : ObservableObject{
    
    @Published var title: String = ""
    @Published var categoryPinnwand : PinnwandCategory = .Sonstiges
    @Published var description : String = ""
    @Published var publishedBy : Rower?
    @Published var publishedDate : Date = Date()
    
    @Published var comments : [Comment] = []
    @Published var currentUser : Rower?
    
    @Published var listOfPinnwandPost : [Pinnwand] = []
    @Published var currentPinnwandPost: Pinnwand?

    @Published var commentsCount : Int = 5

    
    //Allert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var postSuccessful : Bool = false

    
   // Funktion Add Pinnwand Beitrag
    // Funktion delet Pinnwand Beitrag 
    // Add a Comment
    // Delet a Comment
    
    init(){
        fetchCurrentUserDetails()
        loadPinnwandPosts()
    }
    
    func loadPinnwandPosts() {
        FirebaseManager.shared.fireStore.collection("pinnwandPost")
            .order(by: "publishedDate", descending: true) // Sortiere die Posts nach Datum, neueste zuerst
            .getDocuments { [weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    self?.alertMessage = "Fehler beim Laden der Beiträge: \(err.localizedDescription)"
                    self?.showAlert = true
                } else {
                    self?.listOfPinnwandPost = querySnapshot?.documents.compactMap { document -> Pinnwand? in
                        try? document.data(as: Pinnwand.self)
                    } ?? []
                }
            }
    }

    
    func savePinnwandPost(){
        
        let pinnwandPost = Pinnwand(title: self.title, categoryPost: self.categoryPinnwand, description: self.description, publishedBy: self.publishedBy!, publishedDate: self.publishedDate, commentsCount: self.commentsCount)
        
        do {
            let _ = try FirebaseManager.shared.fireStore.collection("pinnwandPost").addDocument(from: pinnwandPost) { error in
                if let error = error {
                    self.alertMessage = "Fehler beim Speichern des Posts."
                    self.showAlert = true
                    print("Error saving request: \(error)")
                } else {
                    print("Post successfully saved")
                    
                    self.resetPostValuesToDefault()
                }
            }
        } catch let error {
            print("Error encoding request: \(error)")
        }
    }
    
    func deletePinnwandPost(pinnwandPost: Pinnwand) {
        guard let currentUserID = FirebaseManager.shared.auth.currentUser?.uid else {
            self.alertMessage = "Nicht angemeldet."
            self.showAlert = true
            return
        }
        
        let isAuthor = currentUserID == pinnwandPost.publishedBy.id
        let isAdmin = currentUserIsAdmin()
        
        if isAuthor || isAdmin {
            if let postID = pinnwandPost.id {
                FirebaseManager.shared.fireStore.collection("pinnwandPost").document(postID).delete() { error in
                    if let error = error {
                        self.alertMessage = "Fehler beim Löschen des Posts: \(error.localizedDescription)"
                        self.showAlert = true
                    } else {
                        self.alertMessage = "Post erfolgreich gelöscht."
                        self.showAlert = true
                    }
                }
            } else {
                self.alertMessage = "Post ID nicht verfügbar."
                self.showAlert = true
            }
        } else {
            self.alertMessage = "Sie sind nicht berechtigt, diesen Post zu löschen."
            self.showAlert = true
        }
    }

    private func currentUserIsAdmin() -> Bool {
        guard let user = currentUser else {
            self.alertMessage = "Nicht angemeldet."
            self.showAlert = true
            return false
        }
        
        return user.admin
    }

    
    func addComment(toPostWithID postID: String, content: String) {
        guard let currentUser = currentUser else {
            self.alertMessage = "Bitte melden Sie sich an, um einen Kommentar hinzuzufügen."
            self.showAlert = true
            return
        }
        
        let newComment = Comment(content: content, author: currentUser.id, timestamp: Date())

        let postRef = FirebaseManager.shared.fireStore.collection("pinnwandPost").document(postID)
        let commentsRef = postRef.collection("comments")

        do {
            try commentsRef.addDocument(from: newComment) { error in
                if let error = error {
                    self.alertMessage = "Fehler beim Hinzufügen des Kommentars: \(error.localizedDescription)"
                    self.showAlert = true
                } else {
                    self.loadComments(forPostWithID: postID)
                }
            }
        } catch {
            self.alertMessage = "Fehler beim Kodieren des Kommentars: \(error.localizedDescription)"
            self.showAlert = true
        }
    }


    func loadComments(forPostWithID postID: String) {
           let commentsRef = FirebaseManager.shared.fireStore.collection("pinnwandPost").document(postID).collection("comments")

           commentsRef.order(by: "timestamp", descending: true).getDocuments { [weak self] (snapshot, error) in
               if let error = error {
                   print("Error loading comments: \(error)")
                   return
               }

               guard let documents = snapshot?.documents else {
                   print("No comments found for post ID \(postID)")
                   return
               }

               let comments = documents.compactMap { document -> Comment? in
                   return try? document.data(as: Comment.self)
               }

               DispatchQueue.main.async {
                   self?.comments = comments
                   self?.currentPinnwandPost?.commentsCount = comments.count
                   self?.objectWillChange.send()
               }
           }
       
        
       }

    func fetchCurrentUserDetails() {
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        FirebaseManager.shared.fireStore.collection("user").document(currentUser).getDocument { [weak self] document, error in
            guard let self = self else { return }
            // ToDo Recap
            if let document = document, document.exists, let user = try? document.data(as: Rower.self) {
                DispatchQueue.main.async {
                    self.publishedBy = user
                    self.currentUser = user
                }
            } else if let error = error {
                print("Error fetching user details: \(error)")
            }
        }
    }
    
    func fetchUserDetails(byID userID: String, completion: @escaping (Rower?) -> Void) {
        FirebaseManager.shared.fireStore.collection("user").document(userID).getDocument { document, error in
            if let document = document, document.exists, let user = try? document.data(as: Rower.self) {
                DispatchQueue.main.async {
                    completion(user)
                }
            } else {
                if let error = error {
                    print("Error fetching user details: \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
    }

    
  
    
    private func resetPostValuesToDefault() {
        self.title = ""
        self.categoryPinnwand  = .Sonstiges
        self.description = ""
        self.publishedDate = Date()
    }
    
    
    
    
}
