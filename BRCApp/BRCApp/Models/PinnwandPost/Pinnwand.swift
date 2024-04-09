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
    var subTitle : String
    var description : String
    var publishedBy : Rower
    var publishedDate : Date = Date()
    var commentSection : [Comment]
}
