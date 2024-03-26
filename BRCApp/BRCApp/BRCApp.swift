//
//  BRCAppApp.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import SwiftUI
import Firebase
import FirebaseAuth


@main
struct BRCApp: App {
    
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    init(){
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        //weiter init von Setup
    }
    
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.userIsLoggedIn{
                MainTabView()
            } else{
                AuthenticationView()
                  .preferredColorScheme(.light) // Light oder Darkmodus erzwingen
                }
        } .environmentObject(authViewModel)
            
    }
}
