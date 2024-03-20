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
    
    @Published var selectedBoatType = BoatType.double
    @Published var selectedRowingStyle = RowingStyle.skull
    @Published var skillLevel = SkillLevel.beginner
    @Published var rowingDate = Date()
    @Published var distance = 10.0
    @Published var rowerList: [Rower?] = []
    @Published var notes = ""
    @Published var publishedBy: Rower?
    @Published var availableSeats: Int = 0
    
    var isPublisherInBoat: Bool {
            guard let publisherId = publishedBy?.id else { return false }
            return rowerList.contains(where: { $0?.id == publisherId })
        }

    
    init(){
        fetchCurrentUserDetails()
    }

    func fetchCurrentUserDetails() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("User not logged in")
            return
        }

        FirebaseManager.shared.fireStore.collection("user").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let document = document, document.exists, let user = try? document.data(as: Rower.self) {
                DispatchQueue.main.async {
                    self.publishedBy = user
                }
            } else if let error = error {
                print("Error fetching user details: \(error)")
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
        let totalSeats = selectedBoatType.numberOfSeats // Zugriff auf die numberOfSeats Eigenschaft des Enums.
        let occupiedSeats = rowerList.compactMap { $0 }.count // Zählt nur nicht-nil Ruderer
        self.availableSeats = totalSeats - occupiedSeats // Aktualisiert das @Published Property
    }

    
//    func calculateAvailableSeats() {
//        let totalSeats = selectedBoatType.numberOfSeats.hashValue // Stellen Sie sicher, dass Ihr BoatType enum ein totalSeats Attribut hat.
//           let occupiedSeats = rowerList.count
//        let remainingSeats = (Int(totalSeats)) - occupiedSeats
//          availableSeats = (Int(remainingSeats))
//       }
    
    
}
