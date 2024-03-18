//
//  SideMenuView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 18.03.24.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var menuItems: [SideMenuItem] = []
    
    init(authViewModel: AuthenticationViewModel) {
        // Menüelemente erstellen und Aktionen definieren
        menuItems = [
            SideMenuItem(id: UUID(), text: "Profil", icon: "person", action: {
                // Navigiere zum Profil
                NavigationLink(<#LocalizedStringKey#>, destination: ProfilView())
                print("Profil ausgewählt")
            }),
            SideMenuItem(id: UUID(), text: "Einstellungen", icon: "gear", action: {
                // Navigiere zu den Einstellungen
                print("Einstellungen ausgewählt")
            }),
            SideMenuItem(id: UUID(), text: "Übern Club", icon: "gear", action: {
                // Navigiere zu den Einstellungen
                print("Club Info Page")
            }),
            SideMenuItem(id: UUID(), text: "Abmelden", icon: "arrow.right.square", action: {
                // Führe Abmeldeprozess durch
                authViewModel.logout()
            })
        ]
    }
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(menuItems){ item in
                        HStack{
                            Image(systemName: item.icon)
                            Text(item.text)
                        }
                    }
                }
            }
        }
    }
}
    
    #Preview {
        SideMenuView(authViewModel: AuthenticationViewModel())
    }

