//
//  Satellite.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 28.03.24.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
