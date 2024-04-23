import Foundation

struct Event: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let startDate: Date
    let location: String
    let imageUrl: String

    // Berechnete Eigenschaft für Countdown
    var countdown: String {
        let calendar = Calendar.current
        let currentDate = Date()
        let eventDate = calendar.startOfDay(for: startDate)

        if currentDate < eventDate {
            let components = calendar.dateComponents([.day, .hour, .minute], from: currentDate, to: eventDate)
            if let day = components.day, let hour = components.hour {
                return "Countdown: \(day) Tagen & \(hour) Stunden"
            } else {
                return "Zeitberechnung nicht verfügbar"
            }
        } else {
            return "Event vorbei"
        }
    }
}
