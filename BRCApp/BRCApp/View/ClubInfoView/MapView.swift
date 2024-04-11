//
//  MapView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.04.24.
//
import SwiftUI
import MapKit

// Definiere eine Struktur, die Identifiable ist, um Annotationen zu repräsentieren.
struct Location: Identifiable {
    let id = UUID() // Automatische eindeutige ID für jede Instanz.
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.41864, longitude: 13.17178),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    // Definiere ein Array von Locations für die Annotationen.
    let locations = [Location(coordinate: CLLocationCoordinate2D(latitude: 52.41864, longitude: 13.17178))]

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack {
                    Image(systemName: "pin.fill")
                        .foregroundColor(.red)
                        .font(.title)
                    Text("BRC")
                        .font(.caption)
                }
            }
        }
        .frame(height: 200)
        .cornerRadius(8)
    }
}


