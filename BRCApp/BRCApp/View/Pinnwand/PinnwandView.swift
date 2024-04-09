//
//  NewsView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct PinnwandView: View {
    @Binding var selectedTab: Tabs
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @StateObject var pinnwandViewModel = PinnwandViewModel()
    @State var showingAddSheet = false
    
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(pinnwandViewModel.listOfPinnwandPost){ post in
                    NavigationLink("PinnwandDetailView", destination: PinnwandDetailView(pinnwandPost: post, viewModel: pinnwandViewModel))
                    VStack(alignment: .leading) {
                        Text(post.title).font(.headline)
                        Text(post.subTitle).font(.subheadline)
                        Text(post.description).lineLimit(2)
                    }
                    
                }.onAppear(perform: PinnwandViewModel.loadPinnwandPosts(self.pinnwandViewModel))
                   
            } .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Request", systemImage: "plus"){
                        
                        showingAddSheet = true
                    }.sheet(isPresented: $showingAddSheet){
                        PinnwandAddView(pinnwandViewModel: pinnwandViewModel)
                    }
                }
            }.navigationTitle("Pinnwand")
        }
        
    }
    
    
    
}

#Preview {
    PinnwandView(selectedTab: .constant(.newsView))
}
