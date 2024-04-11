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
    
    
    @State private var selectedTab: Tabs = .homeView
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            HomeView(LGRViewModel: LetsGoRowingViewModel.init(), selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tabs.homeView)
            
            LetsGoRowingView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Rowing", systemImage: "flag.checkered")
                }
                .tag(Tabs.letsGoRowingView)
            
            PinnwandView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Pinnwand", systemImage: "newspaper")
                }
                .tag(Tabs.newsView)
            
            ChatView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Chat", systemImage: "bubble")
                }
                .tag(Tabs.chatView)

        }
        
    }
}

#Preview {
    MainTabView()
}
