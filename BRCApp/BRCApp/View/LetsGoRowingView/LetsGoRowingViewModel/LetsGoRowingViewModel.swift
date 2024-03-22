//
//  LetsGoRowingViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LetsGoRowingViewModel: ObservableObject{
    
    //LetsGoRowingRequest
    @Published var selectedBoatType = BoatType.double
    @Published var selectedRowingStyle = RowingStyle.skull
    @Published var skillLevel = SkillLevel.beginner
    @Published var rowingDate = Date()
    @Published var distance = 10.0
    @Published var rowerList: [Rower?] = []
    @Published var notes = ""
    @Published var publishedBy: Rower?
    @Published var availableSeats: Int = 0
    @Published var requestClosed : Bool = false

    
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
        return rowerList.contains(where: { $0?.id == publisherId })
    }
    
    
    init(){
        fetchCurrentUserDetails()
        fetchAllUsers()
        updateAvailableSeats()
    }
    
    func fetchCurrentUserDetails() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        FirebaseManager.shared.fireStore.collection("user").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            // ToDo Recap
            if let document = document, document.exists, let user = try? document.data(as: Rower.self) {
                DispatchQueue.main.async {
                    self.publishedBy = user
                }
            } else if let error = error {
                print("Error fetching user details: \(error)")
            }
        }
    }
    
    
    func saveRowerRequest() {
        
        let rowerRequest = LetsGoRowingRequest(id: UUID(), publishedBy: self.publishedBy, boatType: self.selectedBoatType, rowingStyle: self.selectedRowingStyle, rowingDate: self.rowingDate, availableSeats: self.availableSeats, requestClosed: self.requestClosed, skillLevel: self.skillLevel)
        
        do {
            let _ = try FirebaseManager.shared.fireStore.collection("rowerRequests").addDocument(from: rowerRequest) { error in
                if let error = error {
                    print("Error saving request: \(error)")
                } else {
                    print("Request successfully saved")
                }
            }
        } catch let error {
            print("Error encoding request: \(error)")
        }
    }
    
    func fetchAllRequests() {
        FirebaseManager.shared.fireStore.collection("rowerRequests").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting requests: \(error.localizedDescription)")
            } else if let querySnapshot = querySnapshot {
                DispatchQueue.main.async {
                    self?.listOfRequest = querySnapshot.documents.compactMap { document in
                        try? document.data(as: LetsGoRowingRequest.self)
                    }
                }
            }
        }
    }


    
    
    func addPublisherToRowerList() {
        
        if let publisher = publishedBy {
            if !rowerList.contains(where: { $0?.id == publisher.id }) {
                rowerList.append(publisher)
            }
        }
        updateAvailableSeats()
    }
    
    func removePublisherFromRowerList() {
        if let publisherId = publishedBy?.id {
            rowerList.removeAll { $0?.id == publisherId }
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
    
    
    func updateAvailableSeats() {
        let totalSeats = selectedBoatType.numberOfSeats
        let occupiedSeats = rowerList.compactMap { $0 }.count // Zählt nur nicht-nil Ruderer
        self.availableSeats = totalSeats - occupiedSeats
    }
    
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
        
        if !rowerList.contains(where: { $0?.id == rower.id }) {
            rowerList.append(rower)
            updateAvailableSeats()
            updateRequestClosedStatus()
        }
    }
    
    func removeRowerFromRowerList(rower: Rower) {
        rowerList.removeAll { $0?.id == rower.id }
        updateAvailableSeats()
        updateRequestClosedStatus()
    }
    
    func filterUsers(with searchText: String) {
        if searchText.isEmpty {
            filterUsers = allUsers
        } else {
            filterUsers = allUsers.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.lastName.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func updateRequestClosedStatus() {
        // `requestClosed` wird auf `true` gesetzt, wenn keine verfügbaren Sitze mehr vorhanden sind
        requestClosed = availableSeats == 0
    
        print("\(requestClosed) Test")
    }
    
    
    
}
