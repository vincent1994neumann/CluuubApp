//
//  SkillLevel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 15.03.24.
//

import Foundation
import SwiftUI

enum SkillLevel: String, CaseIterable, Codable{
    var id: String{self.rawValue}
    case beginner = "Anfänger"
    case advanced = "Fortgeschritten"
    case competitive = "Wettkampf"
    case extrem = "Leistungssport"
    
    var skillColor : Color{
        switch self{
        case.beginner:
            return Color(.systemYellow)
            
        case.advanced:
            return Color(.green)
            
        case.competitive:
            return Color(.blue)
            
        case.extrem:
            return Color(.black)
            
        }
    }
    
}
