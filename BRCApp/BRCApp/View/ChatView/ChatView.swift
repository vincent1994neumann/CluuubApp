//
//  ChatView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct ChatView: View {
    @Binding var selectedTab: Tabs
    @StateObject var viewModel = ChatSenderViewModel()
    @State var searchText = ""
    
    var body: some View {
        
        NavigationStack{
            VStack{
                List(viewModel.filterUsers.sorted(by: {$0.lastName < $1.lastName}), id: \.id){ user in
                    NavigationLink(destination: ChatDetailView(viewModel: viewModel, recipient: user)){
                        DetailContact(name: user.name, lastName: user.lastName)
                    }
                }
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear(perform: viewModel.fetchAllUsers)
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
        .onChange(of: searchText){ newValue in
            viewModel.filterUsers(with: newValue)
        }
    }
}

#Preview {
    ChatView(selectedTab: .constant(.chatView))
}

struct DetailContact: View {
    
    var name: String
    var lastName : String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.caption)
            Text(lastName)
                .bold()
     
                
            Spacer()
//            
//            Button("", systemImage: "bubble"){
//                
//            }
            
        }
    }
}
