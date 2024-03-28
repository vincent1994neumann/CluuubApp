//
//  SideMenuView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 18.03.24.
//

import SwiftUI


struct SideMenuView: View {
    @Binding var isShowing: Bool
   
    
    var menuItems = [
        SideMenuItem(sideMenuTabName: "Profil", imageSystemName: "person", destination: AnyView(ProfilView())),
        SideMenuItem(sideMenuTabName: "Einstellungen", imageSystemName: "gear", destination: AnyView(SettingsView())),
        SideMenuItem(sideMenuTabName: "Übern Club", imageSystemName: "star.fill", destination: AnyView(ClubInfoView()))
    ]
    
    
    var body: some View {
        
        VStack{
            Image("BRC_Logo")
                .resizable()
                .scaledToFit()
            List{
                ForEach(menuItems){ item in
                    NavigationLink(destination: item.destination){
                        HStack{
                            Image(systemName: item.imageSystemName)
                            Text(item.sideMenuTabName)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        SideMenuView(isShowing: .constant(true))
    }
    
}

