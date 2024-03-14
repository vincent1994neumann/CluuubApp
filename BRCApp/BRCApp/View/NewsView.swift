//
//  NewsView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct NewsView: View {
    @Binding var selectedTab: Tabs
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    var body: some View {
        
        Button("Sign Out"){
            authViewModel.logout()
            
        }
    }
}

#Preview {
    NewsView(selectedTab: .constant(.newsView))
}
