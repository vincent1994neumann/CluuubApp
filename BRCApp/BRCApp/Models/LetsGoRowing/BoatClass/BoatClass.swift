//
//  BoatClass.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 14.03.24.
//

import Foundation

struct BoatClass : Codable {
    var boatType : BoatType
    var rowingStyle : RowingStyle
    var isCoxed : Bool
    var seatCount : Int
}
