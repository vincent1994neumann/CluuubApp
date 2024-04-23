//
//  switchBlueGreen.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 23.04.24.
//

import Foundation
import SwiftUI

enum SwitchBlueGreen : String, Codable, CaseIterable {
    
    case sender = "Sender"
       case receiver = "Receiver"
    
    var bubbleColor: Color {
        switch self {
        case .sender:
            return .blue
        
        case .receiver:
            return .green
        }
    }
}

