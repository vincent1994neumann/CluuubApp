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
      }
    
    
    
}
