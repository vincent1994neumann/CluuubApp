//
//  SideMenuEnum.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import Foundation
import SwiftUI


struct SideMenuItem: Identifiable{
    let id = UUID()
    let sideMenuTabName : String
    let imageSystemName: String
    let destination : AnyView
}
