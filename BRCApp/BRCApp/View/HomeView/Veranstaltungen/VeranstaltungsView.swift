//
//  VeranstaltungsView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 10.04.24.
//

import SwiftUI

struct VeranstaltungsView: View {
    @StateObject var viewModel = VeranstaltungsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.events) { event in
                    VStack(alignment: .leading) {
                        Text(event.name)
                            .font(.headline)
                        Text(event.description)
                            .font(.subheadline)
                        Text("Start: \(event.startDate, formatter: VeranstaltungsView.itemFormatter)")
                            .font(.caption)
                        Text("Ende: \(event.endDate, formatter: VeranstaltungsView.itemFormatter)")
                            .font(.caption)
                        Text("Ort: \(event.location)")
                            .font(.caption)
                    }
                    .frame(width: 320, height: 150)
                    
                    Divider()
                }
            }
        }
    }

    static var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}


//struct VeranstaltungsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VeranstaltungsView()
//    }
//}


#Preview {
    VeranstaltungsView()
}
