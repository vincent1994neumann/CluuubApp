//
//  Pinnwand.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 01.04.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Pinnwand : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var categoryPost : PinnwandCategory
    var description : String
    var publishedBy : Rower
    var publishedDate : Date = Date()
    var commentsCount : Int 
    //var commentSection : [Comment]
}
