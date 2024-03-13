//
//  Rower.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import Foundation

struct Rower: Codable{
    let id : String
    let name : String
    let lastName : String
    let age : Int
    let eMail : String
    let password : String
    let skull: Bool
    let riemen : Bool
    let bb : Bool
    let sb : Bool
    var trailerDrivingLicence = false
    var admin = false
}
