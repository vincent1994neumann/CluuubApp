//
//  RowerUser.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import Foundation

struct RowerUser : Codable {
    let id : UUID
    let name : String
    let lastName : String
    let age : Int
    let eMail : String
    let password : String
    let skull : Bool
    let riemen : Bool
    let sb : Bool
    let bb : Bool
    var haengerSchein = false
    var admin = false
}
