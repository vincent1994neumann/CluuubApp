//
//  BRCAppApp.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import SwiftUI

@main
struct BRCApp: App {
    
    @StateObject private var authViewModel =
    AuthenticationView
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
