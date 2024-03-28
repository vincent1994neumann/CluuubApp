import SwiftUI

struct RequestDetailView: View {
    var request: LetsGoRowingRequest
    
    var body: some View {
        List {
            Section(header: Text("Allgemeine Informationen")) {
               
                if let publisher = request.publishedBy {
                    DetailRow(label: "Veröffentlicht von", value: publisher.fullName)
                }
                DetailRow(label: "Rudertermin", value: request.rowingDate.formatted(date: .abbreviated, time: .shortened))
            }
            
            Section(header: Text("Ruderdetails")) {
                DetailRow(label: "Ruderstil", value: request.rowingStyle.rawValue)
                DetailRow(label: "Bootsklasse", value: request.boatType.rawValue)
                DetailRow(label: "Verfügbare Sitze", value: String(request.availableSeats))
                DetailRow(label: "Fähigkeitsniveau", value: request.skillLevel.rawValue)
                if let distance = request.distance {
                    DetailRow(label: "Distanz", value: String(format: "%.2f km", distance))
                }
            }
            
            if !request.rowerList.isEmpty {
                            Section(header: Text("Eingetragene Ruderer")) {
                                ForEach(request.rowerList, id: \.id) { rower in
                                  //  NavigationLink(destination: ProfilView(rower: rower)) {
                                        Text(rower.fullName)
                                   // }
                                }
                            }
                        }
            
            if let notes = request.notes, !notes.isEmpty {
                Section(header: Text("Notizen")) {
                    Text(notes)
                }
            }
        }
        .navigationTitle("Request Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
    }
}
