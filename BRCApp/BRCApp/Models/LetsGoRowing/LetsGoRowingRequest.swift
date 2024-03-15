//
//  LetsGoRowing.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 14.03.24.
//

import Foundation

struct LetsGoRowingRequest : Codable, Identifiable {
    let id : UUID
    var boatClass : BoatClass
    let publishedBy : Rower
    var publishedDate = Date()
    let rowingDate : Date
    let totalSeats : Int
    var availableSeats : Int { // Berechne die verfügbaren Sitze basierend auf der aktuellen Crew
        totalSeats - boatClass.crew.count
    }
    let rowerList : [Rower] {
        boatClass.crew
    }
    var requestClosed : Bool
    var skillLevel : SkillLevel
    var duration : TimeInterval?
    var distance: Double?
    var notes : String?
    
}
