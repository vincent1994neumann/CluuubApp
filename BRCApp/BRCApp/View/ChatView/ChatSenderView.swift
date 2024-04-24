//
//  ChatSenderView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 17.04.24.
//

import SwiftUI

struct ChatSenderView: View {
    var text :String
    var timeStamp : String
    var currentUserName : String
    var messageType: SwitchBlueGreen
    
    
    var body: some View {
        HStack{
            if messageType == .sender {
                            Spacer()
            }
            VStack {
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)  // Stellen Sie sicher, dass der Text linksbündig ist
      
                HStack {
                    Text(currentUserName)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.leading, 8)

                    Spacer()
                    Text(timeStamp)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                }
                .padding(.top,6)
                
            } .padding(10)
                .frame(width: 310)
                .foregroundColor(.white)
                .background(messageType.bubbleColor)
                .cornerRadius(15)
                .padding(messageType == .receiver ? .leading : .trailing, 20)  // Stellen Sie sicher, dass die Polsterung auf der korrekten Seite ist

            
            if messageType == .receiver {
                Spacer()
            }
        }
    }
    
    
    
    func SenderBubble() {
        
    }
    
}

