//
//  LetsGoRowingView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct LetsGoRowingView: View {
    @Binding var selectedTab: Tabs
    @Environment(\.dismiss) private var dismiss
    @State var showingAddRequestSheet = false
    
    var body: some View {
        NavigationStack{
            VStack{
                
                
                
                
                
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Request", systemImage: "plus"){
                       
                        showingAddRequestSheet = true
                    }.sheet(isPresented: $showingAddRequestSheet){
                        LetsGoRowingRequestView()
                    }
                }
            }.navigationTitle("Let's Go Rowing")
        }
    }
}


#Preview {
    LetsGoRowingView(selectedTab: .constant(.letsGoRowingView))
}
