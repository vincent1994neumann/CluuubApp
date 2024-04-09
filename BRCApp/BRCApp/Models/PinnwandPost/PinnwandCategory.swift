//
//  PinnwandCategory.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 09.04.24.
//

import Foundation

enum PinnwandCategory : String, CaseIterable, Codable{
    
    case Tauschbörse = "Tauschbörse"
    case Verschenken = "Verschenken"
    case Verkaufen = "Verkaufen"
    case Suchen = "Suchen"
    case Wiederfinden = "Wiederfinden"
    case Helfersuche = "Helfersuche"
    case Sportpartner = "Sportpartner"
    case Sonstiges = "Sonstiges"
}
