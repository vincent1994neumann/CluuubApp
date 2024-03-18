//
//  SideMenuEnum.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import Foundation

struct SideMenuItem: Identifiable{
    let id: UUID
    let text : String
    let icon: String
    let action : () -> Void 
}
