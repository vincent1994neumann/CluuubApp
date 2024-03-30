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
    @Published var password: String = ""
    @Published var correctPassword : String = ""
    @Published var name: String = ""
    @Published var lastName : String = ""
    @Published var age : String = ""
    @Published var skull : Bool = false
    @Published var riemen : Bool = false
    @Published var bb : Bool = false
    @Published var sb : Bool = false
    @Published var trailerDrivingLicence: Bool = false
    @Published var admin: Bool = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var registrationSuccessful : Bool = false
  
    
    var userIsLoggedIn : Bool { // Prüft ob der User eingeloggt ist
        self.user != nil
    }
    
    init(){
        checkAuth()
    }
    
    
    private func checkAuth(){
        guard let currentUser = FirebaseManager.shared.auth.currentUser else {
            print("user not logged in")
            return
        }
        self.fetchFireUser(withId: currentUser.uid)
        
    }
    
    
    func register(){
        FirebaseManager.shared.auth.createUser(withEmail: self.emailAdress, password: self.password){
            authResult, error in
            if let user = self.handleAuthResult(authResult: authResult, error: error){
                let fireUser = Rower(id: user.uid, name: self.name, lastName: self.lastName, age: self.age, eMail: self.emailAdress, skull: false, riemen: false, bb: false, sb: false, trailerDrivingLicence: false, admin: false)
                do{
                    try FirebaseManager.shared.fireStore.collection("user").document(user.uid).setData(from: fireUser)
                }catch{
                    print("Registrierung fehlgeschlagen: \(error)")
                }
            }
        }
    }
    
    private func handleAuthResult(authResult: AuthDataResult?, error: Error?) -> User? {
        if let error = error {
            self.alertMessage = "Es ist ein Fehler aufgetreten: \(error.localizedDescription)"
            self.showAlert = true
            return nil
        }else if let user = authResult?.user {
            
            return user
        }
        return nil
    }
    
    
    func login() {
        FirebaseManager.shared.auth.signIn(withEmail: self.emailAdress, password: self.password){
            authResult, error in
            if let user = self.handleAuthResult(authResult: authResult, error: error){
                self.fetchFireUser(withId: user.uid)
            }
        }
    }
    
    
    
    func fetchFireUser(withId id : String){
        FirebaseManager.shared.fireStore.collection("user").document(id).getDocument{document, error in
            if let error {
                print("Error beim Abrufen des Users \(id): \(error)")
                return
            }
            guard let document else {
                print("Document mit id \(id) ist leer")
                return
            }
            do{
                let fireUser = try document.data(as: Rower.self)
                self.user = fireUser
            } catch{
                print("Error beim setzen des Users \(error)")
            }
        }
    }
    
    
    
    
    //Überprüfung, ob alle LogIn Felder befüllt wurden.
    func validateLoginFields() -> Bool {
        if emailAdress.isEmpty || password.isEmpty {
            alertMessage = "Bitte geben Sie Ihre Login-Daten korrekt ein."
            showAlert = true
            return false
        }
        return true
    }
    
    func validateRegisterFields() -> Bool {
        if name.isEmpty || lastName.isEmpty || emailAdress.isEmpty || password.isEmpty || password != correctPassword || age.isEmpty || Int(age) == nil { //Checked ob die Eingabe konvertierbar in ein INT ist
            self.alertMessage = "Bitte vervollständigen Sie Ihre Angaben. Stellen Sie sicher, dass alle Felder korrekt ausgefüllt sind, einschließlich Name, Alter, E-Mail und Passwort."
            self.showAlert = true
            registrationSuccessful = false
            return false
        }else{
            self.alertMessage = "Herzlich Willkommen \(self.name)\nSie haben sich erfolgreich registriert.\nE-Mail: \(self.emailAdress)"
            self.showAlert = true
            registrationSuccessful = true
            return true
        }
    }
    
    func logout() {
        do{
            try FirebaseManager.shared.auth.signOut()
            self.user = nil
        }catch{
            print("Error beim Ausloggen \(error)")
        }
    }
    
    
}
