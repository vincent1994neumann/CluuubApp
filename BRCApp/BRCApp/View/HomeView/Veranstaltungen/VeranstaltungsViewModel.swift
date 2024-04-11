//
//  VeranstaltungsViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 10.04.24.
//
import Foundation

class VeranstaltungsViewModel: ObservableObject {
    @Published var events = [Event]()

    init() {
        loadEvents()
    }

    func loadEvents() {
        // Hier würden normalerweise Netzwerkanfragen oder Datenbankabfragen stattfinden, Dummydaten
        self.events = eventData
    }
}

