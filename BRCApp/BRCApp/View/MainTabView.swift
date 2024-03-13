//
//  HomeView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 12.03.24.
//

import SwiftUI

enum Tabs {
    case    homeView
    case    letsGoRowingView
    case    newsView
    case    chatView
}

struct MainTabView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @State private var selectedTab: Tabs = .homeView
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
        }
        
        Button("Sign Out"){
            authViewModel.logout()
            
        }
    }
}

#Preview {
    MainTabView()
}
