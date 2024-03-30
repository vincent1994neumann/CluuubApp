//
//  ProfilViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 28.03.24.
//

import Foundation

class ProfilViewModel: ObservableObject {
    @Published var user: Rower?

    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Kein Benutzer angemeldet")
            return
        }

        let docRef = FirebaseManager.shared.fireStore.collection("user").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.user = try? document.data(as: Rower.self)
            } else {
                print("Dokument existiert nicht")
            }
        }
    }
}
