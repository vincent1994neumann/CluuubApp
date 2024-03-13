//
//  HomeView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 12.03.24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Sign Out"){
            authViewModel.logout()
            
        }
    }
}

#Preview {
    HomeView()
}
