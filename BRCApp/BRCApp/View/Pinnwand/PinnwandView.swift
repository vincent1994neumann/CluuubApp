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
        NavigationStack {
                   ScrollView {
                       VStack(spacing: 8){
                           ForEach(pinnwandViewModel.listOfPinnwandPost) { post in
                               NavigationLink(destination: PinnwandDetailView(pinnwandPost: post, viewModel: pinnwandViewModel)) {
                                   VStack(alignment: .leading, spacing: 10) {
                                       Text(post.title).font(.headline)
      //                                 Text("\(pinnwandViewModel.categoryPost)")
                                       Text(post.description).lineLimit(2)
                                       Text("Veröffentlicht von \(post.publishedBy.lastName)").font(.footnote)
                                   }
                                   .padding()
                                   .frame(maxWidth: .infinity, minHeight: 100)
                                   .background(Color(UIColor.systemBackground))
                                   .cornerRadius(10)
                                   .shadow(radius: 2)
                               }
                           }
                       }
                       .padding(.horizontal)
                   }
              .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                      Button("Add Post", action: {
                          showingAddSheet = true
                      })
                  }
              }
              .sheet(isPresented: $showingAddSheet) {
                  PinnwandAddView(pinnwandViewModel: pinnwandViewModel)
              }
              .navigationTitle("Pinnwand")
              .onAppear {
                  pinnwandViewModel.loadPinnwandPosts()
              }
          }
      }
  }
    
    
    


#Preview {
    PinnwandView(selectedTab: .constant(.newsView))
}
