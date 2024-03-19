//
//  RowingStyle.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 15.03.24.
//

import Foundation

enum RowingStyle : String, CaseIterable, Codable{
    var id: String{self.rawValue}
    case skull = "Skull"
    case riemen = "Riemen"
    
}
