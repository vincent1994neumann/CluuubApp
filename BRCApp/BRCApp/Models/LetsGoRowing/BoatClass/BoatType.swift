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
    
    var numberOfSeats: Int {
        switch self {
        case .double:
            return 2
        case .coxedDouble:
            return 3
        case .quad:
            return 4
        case .coxedQuad:
            return 5
        case .eight:
            return 9
        }
    }
    
    var imageName: String {
         switch self {
         case .double:
             return "double_boat_image"
         case .coxedDouble:
             return "coxed_double_boat_image"
         case .quad:
             return "quad_boat_image"
         case .coxedQuad:
             return "coxed_quad_boat_image"
         case .eight:
             return "eight_boat_image"
         }
     }
}
