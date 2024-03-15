//
//  BoatType.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 15.03.24.
//

import Foundation

struct BoatType: Codable {
    var doubleSkull = [Rower, Rower]
    var quadSkull = [Rower, Rower, Rower, Rower]
    var coxedQuadSkull = [Rower, Rower, Rower, Rower, Rower]
    var coxlessPair = [Rower, Rower]
    var coxlessFour =[Rower, Rower, Rower, Rower]
    var coxedFour = [Rower, Rower, Rower, Rower, Rower]
    var eight = [Rower, Rower, Rower, Rower, Rower, Rower, Rower, Rower, Rower]
    
//    var seatCount: Int {
//        switch self {
//        case .singleSkull: return 1
//        case .doubleSkull: return 2
//        case .quadSkull: return 4
//        case .coxedQuadSkull: return 5
//        case .coxlessPair: return 2
//        case .coxlessFour: return 4
//        case .coxedFour: return 5
//        case .eight: return 9
//        }
//    }
}

