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
                    .padding(.bottom, 24)
                    .padding(.top, 24)
                    .foregroundColor(.blue)
                
                Image("BRC_Logo")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                                                            
                HStack{
                    Text("Logindaten:")
                    Spacer()
                }.padding(.leading, 16)
                
                TextField("E-Mail Adresse", text: $authViewModel.emailAdress)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                
                SecureField("Passwort", text: $authViewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                
                
                Button("Login"){
                    if authViewModel.validateLoginFields(){
                        authViewModel.login()
                    }
                }.buttonStyle(.borderedProminent)
                    .padding(.top, 24)
                
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
                Alert(title: Text("Error"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }//.navigationTitle("Login")
        }
    }
}

#Preview {
    AuthenticationView().environmentObject(AuthenticationViewModel())
}

