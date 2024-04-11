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
        // Hier würden normalerweise Netzwerkanfragen oder Datenbankabfragen stattfinden.
        self.events =  [
            Event(
                name: "Beachparty am Wannsee",
                description: "Feiern Sie den Sommer mit uns am Strand mit Musik, Tanz und Grill!",
                startDate: Calendar.current.date(byAdding: .day, value: 6, to: Date())!,
                location: "Berliner Ruder-Club, Bootsplatz",
                imageUrl: "ClubHausBeachParty"
            ),
            Event(
                name: "Jahreshauptversammlung BRC",
                description: "JHV 2024.",
                startDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
                location: "Berliner Ruder-Club, Hauptsaal",
                imageUrl: "JHV"
            ),
            Event(
                name: "Anrudern im BRC",
                description: "Traditioneller Start in die Rudersaison mit einer gemeinsamen Ausfahrt.",
                startDate: Calendar.current.date(byAdding: .day, value: 12, to: Date())!,
                location: "Berliner Ruder-Club, Bootsplatz",
                imageUrl: "ClubHaus3"
            ),
            Event(
                name: "Ruder-Workshop für Anfänger",
                description: "Lerne die Grundlagen des Ruderns in unserem Workshop für Anfänger.",
                startDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                location: "Berliner Ruder-Club, Bootshaus",
                imageUrl: "ClubHausFront"
            ),
            Event(
                name: "Grillabend am Bootshaus",
                description: "Geselliger Abend mit Grillen und Getränken am Bootshaus.",
                startDate: Calendar.current.date(byAdding: .day, value: 42, to: Date())!,
                location: "Bootshaus BRC, Berlin",
                imageUrl: "Grillen"
            ),
            Event(
                name: "Erste Hilfekurs",
                description: "Erste Hilfe Kurs für alle aktiven Mitglieder",
                startDate: Calendar.current.date(byAdding: .day, value: 43, to: Date())!,
                location: "Trainingsraum BRC, Berlin",
                imageUrl: "ErsteHilfe"
            )
        ]

    }
}

