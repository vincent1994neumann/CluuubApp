//
//  SkillLevel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 15.03.24.
//

import Foundation

enum SkillLevel: String, CaseIterable, Codable{
    var id: String{self.rawValue}
    case beginner = "Anfänger"
    case advanced = "Fortgeschritten"
    case competitive = "Wettkampf"
    case extrem = "Leistungssport"
}
