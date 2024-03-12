//
//  AuthenticationViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationViewModel : ObservableObject{
    @Published var user : Rower?
    @Published var emailAdress : String = ""
    @Published var passwort: String = ""
    @Published var userName: String = ""
    
    var userIsLoggedIn : Bool { // Prüft ob der User eingeloggt ist
        self.user != nil
    }
    
    
    private func checkAuth() {
        guard let currentUser = FirebaseManager.shared.auth.currentUser else {
            print("user not logged in")
            return
        }
         
    }
    
    
    
}
