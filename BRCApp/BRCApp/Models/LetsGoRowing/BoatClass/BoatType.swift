//
//  BoatType.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 15.03.24.
//

import Foundation

enum BoatType: String, CaseIterable, Codable {
    var id: String{self.rawValue}
    
    case double = "Zweier"
    case coxedDouble = "Zweier mit Steuermann"
    case quad = "Vierer"
    case coxedQuad = "Vierer mit Steuermann"
    case eight = "Achter mit Steuermann"
 
    var rowerList: Int {
        switch self {
        case .double:
            2
        case .coxedDouble:
            3
        case .quad:
            4
        case .coxedQuad:
            5
        case .eight:
            9
        }
    }
}
