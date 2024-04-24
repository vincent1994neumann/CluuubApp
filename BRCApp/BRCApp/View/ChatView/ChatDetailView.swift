//
//  ChatDetailView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 23.04.24.
//

import SwiftUI

struct ChatDetailView: View {
    
    @State private var messages: [Message] = []
    @State var newText : String = ""
    @ObservedObject var viewModel : ChatSenderViewModel
    var recipient: Rower  // Empfänger des Chats
    
    
    var body: some View {
        VStack{
            if viewModel.messages.isEmpty {
            Spacer()
                Text("Schreiben Sie eine Nachricht an: \n\(recipient.fullName)")
                .foregroundColor(.gray)
                .italic()
            Spacer()
        } else {
            ScrollView {
                ScrollViewReader { scrollViewProxy in
                    VStack {
                        ForEach(viewModel.messages) { message in
                            ChatSenderView(
                                text: message.text,
                                timeStamp: message.timestamp.formatted(),
                                currentUserName: message.senderId == viewModel.currentUser?.id ? viewModel.currentUser?.fullName ?? "Unbekannt" : recipient.fullName,
                                messageType: message.senderId == viewModel.currentUser?.id ? .sender : .receiver
                            )
                            .id(message.id)
                        }
                    }
                    .onAppear {
                        if let lastMessage = viewModel.messages.last {
                            scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom) // Scrollen zur letzten UI - Message
                        }
                    }
                }
            }

        }
            
            Divider()
            HStack{
                TextField("Schreiben Sie hier...", text: $newText)
                Button("Senden") {
                    viewModel.sendMessage(text: newText, recipientId: recipient.id)
                    newText = ""
                    }
                .disabled(newText.isEmpty)
            } .padding()
            Divider()

        }
        .navigationBarTitle("\(recipient.fullName)")
        .navigationBarTitleDisplayMode(.inline) // Zeigt den Titel in der Navigation Bar an

    
        .onAppear{
            
            viewModel.fetchMessages(with: recipient.id)
        }
    }
}


