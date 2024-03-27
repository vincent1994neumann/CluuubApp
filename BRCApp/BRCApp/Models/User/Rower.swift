//
//  Rower.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import Foundation

 struct Rower: Codable, Identifiable, Equatable{
    let id : String
    let name : String
    let lastName : String
    let age : String
    let eMail : String
    let password : String // sollte hier nicht gespeichert werden
    let skull: Bool
    let riemen : Bool
    let bb : Bool
    let sb : Bool
    var trailerDrivingLicence : Bool
    var admin :Bool
   // var createdRequest: [LetsGoRowingRequest] = []
     //var skillLevel : SkillLevel
     
     var fullName: String {
            "\(name) \(lastName)"
        }
}
