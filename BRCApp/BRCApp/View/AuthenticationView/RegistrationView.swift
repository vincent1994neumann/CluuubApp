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
                            if authViewModel.validateRegisterFields() {
                                authViewModel.register()
                            }
                        }
                        Spacer()
                    }.alert("Hinweis", 
                        isPresented: $authViewModel.showAlert,
                        actions: {
                            Button("OK"){
                            if authViewModel.registrationSuccessful {
                                dismiss()
                                }
                            }
                        },
                        message: {
                            Text(authViewModel.alertMessage)
                            })
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
