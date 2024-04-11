import SwiftUI

struct VeranstaltungsView: View {
    @StateObject var viewModel = VeranstaltungsViewModel() // Stellt sicher, dass dein ViewModel den Countdown enthält

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.events) { event in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(event.name)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .lineLimit(1)

                            Text(event.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                            
                            Text("Ort: \(event.location)")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Start: \(event.startDate, formatter: VeranstaltungsView.itemFormatter)")
                                .font(.caption)
                            
                            // Hier fügen wir den Countdown hinzu
                            Text(event.countdown)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.green) // Du kannst die Farbe nach deinen Wünschen anpassen
                        }

                        Spacer()

                        Image(event.imageUrl) // Stelle sicher, dass diese Bilder lokal verfügbar sind
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color(UIColor.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            }
            .padding(.horizontal)
        }
    }

    static var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
