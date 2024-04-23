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
            VStack(alignment: messageType == .receiver ? .trailing : .leading, spacing: 4) {
                Text(text)
                
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
                .frame(width: 310, alignment: .leading)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15)
                .padding(.trailing, 20)
                .padding(.leading, 20)
        }
    }
    
    
    
    func SenderBubble() {
        
    }
    
}

#Preview {
    ChatSenderView(text: "Test 123 \nHallo, das ist eine Testnachricht!\nHallo, das ist eine Testnachricht!\nHallo, das ist eine Testnachricht!", timeStamp: "XX.XX.XXXX", currentUserName: "Eddie", messageType: .sender)
}
