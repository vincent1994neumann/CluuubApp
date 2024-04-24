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
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            
                            HStack{
                                Text(post.publishedDate, style: .date).font(.footnote)
                                Text(post.publishedDate, style: .time).font(.footnote)
                                Spacer()
                                Text(post.categoryPost.rawValue).font(.footnote)
                            }
                            .foregroundStyle(.black)
                            
                            Text(post.title).font(.headline)
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                                .foregroundStyle(.brown)
                            
                            Divider()
                                .frame(height: 0.5)
                                .background(.blue)
                            Text(post.description).lineLimit(1)
                                .font(.caption)
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                                .foregroundStyle(.gray)
                            HStack{
                                Text("Veröffentlicht von \(post.publishedBy.lastName)").font(.footnote).foregroundStyle(.black)
                                
                                Spacer()
                                NavigationLink(destination: PinnwandDetailView(pinnwandPost: post, viewModel: pinnwandViewModel)) {
                                    Text("Kommentare")
                                        .font(.callout)
                                        .foregroundStyle(.blue)
                                        .italic()
                                    Image(systemName: "bubble.left.and.bubble.right")
                                        .font(.callout)
                                        .foregroundStyle(.blue)
                                        .badge(post.commentsCount)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color(UIColor.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 2)
                        )
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        
                        
                    }
                }
                .padding(.leading, 8)
                .padding(.trailing, 8)
            
                
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Post", systemImage: "plus") {
                        showingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                PinnwandAddView(pinnwandViewModel: pinnwandViewModel)
            }
    
            .navigationTitle("Pinnwand")
            .navigationBarTitleDisplayMode(.inline) // Zeigt den Titel in der Navigation Bar an

            .onAppear {
                pinnwandViewModel.loadPinnwandPosts()
            }
            
        }
    }
        
}





#Preview {
    PinnwandView(selectedTab: .constant(.newsView))
}
