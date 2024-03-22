//
//  LGRVFilterEnum.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 22.03.24.
//

import Foundation

enum MainFilterOptions: String, CaseIterable {
      case open = "Offene Boote"
      case closed = "Geschlossene Boote"
  }

  enum SubFilterOptions: String, CaseIterable {
      case all = "Alle"
      case skull = "Skull"
      case riemen = "Riemen"
  }
