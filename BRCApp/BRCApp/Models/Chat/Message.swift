//
//  Message.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 24.04.24.
//

import Foundation
import FirebaseFirestoreSwift


struct Message : Codable, Identifiable{
    @DocumentID var id: String?
    var text: String
    var senderId: String
    var recipientId: String
    var timestamp: Date
    var isRead : Bool = false
    
    enum CodingKeys: String, CodingKey {
           case id
           case text
           case senderId
           case recipientId
           case timestamp
       }
    
    
}
