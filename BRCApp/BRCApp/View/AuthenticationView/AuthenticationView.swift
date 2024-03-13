//
//  AuthenticationView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import SwiftUI

struct AuthenticationView: View {
    
    let appName = "Berliner Ruder Club"
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @State private var showingRegistrationSheet = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Let's Go Rowing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 32)
                    .padding(.top, 32)
                    .foregroundColor(.blue)
                
                Image("BRC_Logo")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                                                            
                HStack{
                    Text("Logindaten:")
                    Spacer()
                }.padding(.leading, 18)
                
                TextField("E-Mail Adresse", text: $authViewModel.emailAdress)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                
                SecureField("Passwort", text: $authViewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                
                
                Button("Login"){
                    print("Log 1")
                    if authViewModel.validateLoginFields(){
                        authViewModel.login()
                        print("Login done")
                    }
                }.buttonStyle(.borderedProminent)
                    .padding(.top, 20)
                
                Divider()
                    .padding()
                
                VStack {
                    Text("Zum erstenmal hier?")
                        .font(.callout)
                    Button("Hier registrieren!"){
                        showingRegistrationSheet = true
                    }.sheet(isPresented: $showingRegistrationSheet) {
                        RegistrationView().environmentObject(authViewModel)
                    }
                }
                .padding(.top,8)
                
                Spacer()
            }.alert(isPresented: $authViewModel.showAlert) {
                Alert(title: Text("Fehler"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }//.navigationTitle("Login")
        }
    }
}

#Preview {
    AuthenticationView().environmentObject(AuthenticationViewModel())
}

