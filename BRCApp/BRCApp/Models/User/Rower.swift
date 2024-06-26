//
//  Rower.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import Foundation

 struct Rower: Codable, Identifiable{
    let id : String
    let name : String
    let lastName : String
    let age : String
    let eMail : String
    let skull: Bool
    let riemen : Bool
    let bb : Bool
    let sb : Bool
    var trailerDrivingLicence : Bool
    var admin :Bool
    var createdRequests: [String] = []
    var participatedEvents : [String] = []
    var myPosts : [String] = []
     //var skillLevel : SkillLevel
     
     var fullName: String {
            "\(name) \(lastName)"
        }
}
