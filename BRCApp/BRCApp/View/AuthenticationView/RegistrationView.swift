//
//  RegistrationView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    @State private var correctPassword : String = ""
    
    var body: some View {
        NavigationStack{
            
            
            
            Form{
                Section{
                    Text("Bitte gebe deine Daten für die Registrierung ein")
                }
                Section(header: Text("Persönliche Informationen")){
                    TextField("Vorname", text: $authViewModel.name)
                    TextField("Nachname", text: $authViewModel.lastName)
                    TextField("E-Mail Adresse", text: $authViewModel.emailAdress)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Passwort", text: $authViewModel.password)
                    SecureField("Passwort bestätigen", text: $correctPassword)
                }
                Section(header: Text("Persönliche Rudereigenschaften")) {
                    Toggle("Skull", isOn: $authViewModel.skull)
                }
                Section{
                    Toggle("Riemen", isOn: $authViewModel.riemen)
                    Toggle("Backbord", isOn: $authViewModel.bb)
                    Toggle("Steuerbord", isOn: $authViewModel.sb)
                }
            }
            
        }
        
        
    }
}





#Preview {
    RegistrationView().environmentObject(AuthenticationViewModel())
}
