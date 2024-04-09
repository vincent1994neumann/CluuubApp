//
//  LetsGoRowingViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class LetsGoRowingViewModel: ObservableObject{
    
    //LetsGoRowingRequest
    @Published var selectedBoatType = BoatType.double
    @Published var selectedRowingStyle = RowingStyle.skull
    @Published var skillLevel = SkillLevel.beginner
    @Published var rowingDate = Date()
    @Published var distance = 10.0
    @Published var rowerList: [Rower] = []
    @Published var notes = ""
    @Published var publishedBy: Rower?
    @Published var availableSeats: Int = 0
    @Published var requestClosed : Bool = false
    @Published var currentUser : Rower?
    
    
    //Search for Rower
    @Published var allUsers: [Rower] = []
    @Published var searchForRower = ""
    @Published var filterUsers: [Rower] = []
    
    //Allert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var requestSuccessful : Bool = false
    
    //List of Request
    @Published var listOfRequest : [LetsGoRowingRequest] = []
    
    
    var isPublisherInBoat: Bool {
        guard let publisherId = publishedBy?.id else { return false }
        return rowerList.contains(where: { $0.id == publisherId })
    }
    
    
    
    
    
    init(){
        fetchCurrentUserDetails()
        fetchAllUsers()
        updateAvailableSeats()
    }
    
    func isRowerInBoat(for requestId: String) -> Bool {
        guard let currentUserId = currentUser?.id,
              let request = listOfRequest.first(where: { $0.id == requestId }) else {
            return false
        }
        
        return request.rowerList.contains(where: { $0.id == currentUserId })
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
    
    func rowerListInit(){
        guard !rowerList.isEmpty else {
                print("Es muss mindestens ein Ruderer hinzugefügt werden.")
                return
            }
    }
    
    func saveRowerRequest() {
        //Sonst gibt es Probleme mit der Init des Requests - rowerListe !
        rowerListInit()
        //RowerList übergeben
        let rowerRequest = LetsGoRowingRequest(publishedBy: self.publishedBy, boatType: self.selectedBoatType, rowingStyle: self.selectedRowingStyle, rowingDate: self.rowingDate, availableSeats: self.availableSeats, rowerList: self.rowerList, requestClosed: self.requestClosed, skillLevel: self.skillLevel, distance: self.distance, notes: self.notes)
        
        do {
            let _ = try FirebaseManager.shared.fireStore.collection("rowerRequests").addDocument(from: rowerRequest) { error in
                if let error = error {
                    self.alertMessage = "Fehler beim Speichern der Anfrage."
                    self.showAlert = true
                    print("Error saving request: \(error)")
                } else {
                    print("Request successfully saved")
                    
                    self.resetRequestValuesToDefault()  
                    
                }
            }
        } catch let error {
            print("Error encoding request: \(error)")
        }
        print("saveRowerRequest 1")
    }
  
    private func resetRequestValuesToDefault() {
        self.selectedBoatType = .double
        self.selectedRowingStyle = .skull
        self.skillLevel = .beginner
        self.rowingDate = Date()
        self.distance = 10.0
        self.rowerList = []
        self.notes = ""
        self.availableSeats = 0
        self.requestClosed = false
    }

    
    func saveUpdatedRequest(_ request: LetsGoRowingRequest, withId id: String) {
        do {
            try FirebaseManager.shared.fireStore.collection("rowerRequests")
                .document(id)
                .setData(from: request, merge: true) { error in 
                    if let error = error {
                        print("Fehler beim Aktualisieren der Anfrage: \(error.localizedDescription)")
                    } else {
                        print("Anfrage erfolgreich aktualisiert.")
                    }
                }
        } catch let error {
            print("Error encoding request: \(error)")
        }
    }

    
    func toggleRowerInRequest(requestId: String) {
        // Suche den Index der Anfrage mit der gegebenen ID.
        guard let index = listOfRequest.firstIndex(where: { $0.id == requestId }) else {
            print("Anfrage mit der ID \(requestId) nicht gefunden.")
            return
        }
        
        // Hole die Benutzer-ID des aktuellen Firebase User
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Kein Benutzer angemeldet")
            return
        }
        
        // Hole das Rower-Objekt aus der Datenbank
        FirebaseManager.shared.fireStore.collection("user").document(uid).getDocument { [weak self] (documentSnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Fehler beim Abrufen der Benutzerdaten: \(error)")
                return
            }
            
            guard let documentSnapshot = documentSnapshot, let rower = try? documentSnapshot.data(as: Rower.self) else {
                print("Benutzerdaten konnten nicht abgerufen werden.")
                return
            }
            
            // Führe die Updates im Hauptthread aus
            DispatchQueue.main.async {
                
                // Zugriff auf die Anfrage direkt über den Index für direkte Manipulation
                var request = self.listOfRequest[index]
                
                // Überprüfe, ob der Benutzer bereits in der rowerList ist
                if let rowIndex = request.rowerList.firstIndex(where: { $0.id == rower.id }) {
                    // Benutzer ist bereits in der Liste, entferne ihn
                    request.rowerList.remove(at: rowIndex)
                    request.availableSeats += 1
                } else {
                    // Benutzer ist nicht in der Liste, füge ihn hinzu
                    request.rowerList.append(rower)
                    request.availableSeats -= 1
                
                }
                
                // Aktualisiere den Status der Anfrage
                request.requestClosed = request.availableSeats <= 0
                
                // Speichere die aktualisierte Anfrage in Firestore und aktualisiere die lokale Liste
                self.saveUpdatedRequest(request, withId: request.id ?? "Error ID")
                // Da `request` eine Kopie ist, aktualisiere das Original in `listOfRequest`
                self.listOfRequest[index] = request
            }
        }
    }

    func fetchAllRequests() {
        FirebaseManager.shared.fireStore.collection("rowerRequests").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting requests: \(error.localizedDescription)")
            } else if let querySnapshot = querySnapshot {
                DispatchQueue.main.async {
                    self?.listOfRequest.removeAll() // Um eine Dopplung zu vermeiden?
                    self?.listOfRequest = querySnapshot.documents.compactMap { document in
                        try? document.data(as: LetsGoRowingRequest.self)
                        
                    }
                }
                
            }
            
        }
      //  print(listOfRequest)
    }

    
    func updateAvailableSeats() {
        let totalSeats = selectedBoatType.numberOfSeats
        let occupiedSeats = rowerList.compactMap { $0 }.count // Zählt nur nicht-nil Ruderer
        self.availableSeats = totalSeats - occupiedSeats
    }
    
    //Firebase Repo - für alle User -
    func fetchAllUsers() {
        FirebaseManager.shared.fireStore.collection("user")
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error getting user: \(error)")
                    return
                }
                
                // Konvertieren Sie die DocumentSnapshot-Instanzen in Rower-Objekte
                self?.allUsers = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Rower.self)
                } ?? []
            }
    }
    
    func addRowerToRowerList(rower: Rower) {
        
        if !rowerList.contains(where: { $0.id == rower.id }) {
            rowerList.append(rower)
        }
    }
    
    func removeRowerFromRowerList(rower: Rower) {
        rowerList.removeAll { $0.id == rower.id }
    }
    
    func filterUsers(with searchText: String) {
        if searchText.isEmpty {
            filterUsers = allUsers
        } else {
            filterUsers = allUsers.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.lastName.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func updateRequestClosedStatus(for request: inout LetsGoRowingRequest) {
        // `requestClosed` wird auf `true` gesetzt, wenn keine verfügbaren Sitze mehr vorhanden sind
        requestClosed = availableSeats == 0
        
    }
    
   
    func addPublisherToRowerList() {
        
        if let publisher = publishedBy {
            if !rowerList.contains(where: { $0.id == publisher.id }) {
                rowerList.append(publisher)
            }
        }
        updateAvailableSeats()
    }
    
    func removePublisherFromRowerList() {
        if let publisherId = publishedBy?.id {
            rowerList.removeAll { $0.id == publisherId }
          updateAvailableSeats()
        }
    }
    
    func togglePublisherInRowerList() {
        if isPublisherInBoat {
            removePublisherFromRowerList()
        } else {
            addPublisherToRowerList()
        }
       updateAvailableSeats()
    }
    
}
