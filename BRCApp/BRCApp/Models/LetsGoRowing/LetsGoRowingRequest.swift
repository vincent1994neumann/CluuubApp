//
//  LetsGoRowing.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 14.03.24.
//

import Foundation

struct LetsGoRowingRequest : Codable, Identifiable {
    let id : UUID
    let publishedBy : Rower?
    var boatType : BoatType
    var rowingStyle : RowingStyle
    var publishedDate = Date()
    var rowingDate : Date
    var availableSeats : Int 
    var rowerList : [Rower]
    var requestClosed : Bool
    var skillLevel : SkillLevel
    var duration : TimeInterval?
    var distance: Double?
    var notes : String?
}
