//
//  RegistrationView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Persönliche Informationen")){
                    TextField("Vorname", text: $authViewModel.name)
                    TextField("Nachname", text: $authViewModel.lastName)
                    TextField("Alter", text: $authViewModel.age)
                            .keyboardType(.numberPad)
                    
                    TextField("E-Mail Adresse", text: $authViewModel.emailAdress)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Passwort", text: $authViewModel.password)
                    SecureField("Passwort bestätigen", text: $authViewModel.correctPassword)
                }
                
                Section(header: Text("Persönliche Rudereigenschaften")) {
                    Toggle("Skull", isOn: $authViewModel.skull)
                    Toggle("Riemen", isOn: $authViewModel.riemen)
                    Toggle("Backbord", isOn: $authViewModel.bb)
                        .disabled(!authViewModel.riemen)
                    Toggle("Steuerbord", isOn: $authViewModel.sb)
                        .disabled(!authViewModel.riemen)
                }
                
                Section(header: Text("Sonstige Eigentschaften")){
                    Toggle("Hängerfahrer", isOn: $authViewModel.trailerDrivingLicence)
                }
                
                Section{
                    HStack{
                        Spacer()
                        Button("Registrieren"){
                            if authViewModel.validateRegisterFields(){
                                authViewModel.register()
                                dismiss()
                            }else{
                                showingAlert = true
                                alertMessage = "Bitte vervollständigen Sie Ihre Angaben. Stellen Sie sicher, dass alle Felder korrekt ausgefüllt sind, einschließlich Name, Alter, E-Mail und Passwort."

                                
                            }
                            
                        }
                        Spacer()
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text("Fehler"), message: Text(alertMessage))
                    }
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Abbrechen"){
                        dismiss()
                    }
                }
            }.navigationTitle("Registrierung")
        }
    }
}





#Preview {
    RegistrationView().environmentObject(AuthenticationViewModel())
}
