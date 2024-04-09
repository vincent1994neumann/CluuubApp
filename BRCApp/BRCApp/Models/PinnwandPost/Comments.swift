//
//  Comments.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 02.04.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Comment: Codable, Identifiable {
    @DocumentID var id: String?
    var content: String
    var author: String
    var timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case author
        case timestamp
    }
}
