import Foundation

struct Event: Identifiable {
    let id = UUID() // Wir benutzen UUID für eindeutige IDs.
    let name: String
    let description: String
    let startDate: Date
    let endDate: Date
    let location: String
    let imageUrl: String
}

// Wir definieren eine globale Variable, die unser Array von Events enthält.
let eventData = [
    Event(
        name: "Beachparty am Wannsee",
        description: "Feiern Sie den Sommer mit uns am Strand mit Musik, Tanz und Grill!",
        startDate: Date(),
        endDate: Date().addingTimeInterval(6 * 60 * 60), // 6 Stunden später
        location: "Strandbar Wannsee, Berlin",
        imageUrl: "http://example.com/beachparty.jpg"
    ),
    Event(
        name: "Jahreshauptversammlung BRC",
        description: "Jährliche Versammlung für alle Vereinsmitglieder zur Besprechung und Planung des kommenden Jahres.",
        startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!, // 2 Stunden später am nächsten Tag
        location: "Berliner Ruder-Club, Hauptsaal",
        imageUrl: "http://example.com/jahreshauptversammlung.jpg"
    ),
    Event(
        name: "Anrudern auf der Spree",
        description: "Traditioneller Start in die Rudersaison mit einer gemeinsamen Ausfahrt.",
        startDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 4, to: Date())!, // 4 Stunden später
        location: "Spree, Berlin",
        imageUrl: "http://example.com/anrudern.jpg"
    ),
    Event(
        name: "Ruder-Workshop für Anfänger",
        description: "Lerne die Grundlagen des Ruderns in unserem Workshop für Anfänger.",
        startDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!, // 3 Stunden später
        location: "Berliner Ruder-Club, Bootshaus",
        imageUrl: "http://example.com/ruderworkshop.jpg"
    ),
    Event(
        name: "Grillabend am Bootshaus",
        description: "Geselliger Abend mit Grillen und Getränken am Bootshaus.",
        startDate: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 5, to: Date())!, // 5 Stunden später
        location: "Bootshaus BRC, Berlin",
        imageUrl: "http://example.com/grillabend.jpg"
    ),
    Event(
        name: "Wettkampf-Simulatortraining",
        description: "Verbessere deine Technik und Taktik auf dem Ruder-Simulator.",
        startDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
        endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!, // 2 Stunden später
        location: "Trainingsraum BRC, Berlin",
        imageUrl: "http://example.com/simulatortraining.jpg"
    )
]
