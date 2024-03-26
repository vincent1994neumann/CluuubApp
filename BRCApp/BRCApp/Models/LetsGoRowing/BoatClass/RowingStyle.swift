//
//  RowingStyle.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 15.03.24.
//

import Foundation
import SwiftUI

enum RowingStyle : String, CaseIterable, Codable{
    var id: String{self.rawValue}
    case skull = "Skull"
    case riemen = "Riemen"
    
    var strokeColor : Color {
        switch self{
        case.riemen:
            return Color.red
        case.skull:
            return Color.yellow
            
        }
    }
    
}
