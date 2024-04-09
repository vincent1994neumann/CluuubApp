//
//  PinnwandAddView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 02.04.24.
//

import SwiftUI

struct PinnwandAddView: View {
    @ObservedObject var pinnwandViewModel : PinnwandViewModel
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Post Details")) {
                    TextField("Titel", text: $pinnwandViewModel.title)
                    Picker("Kategorie", selection: $pinnwandViewModel.categoryPinnwand){
                        ForEach(PinnwandCategory.allCases, id: \.self){ style in
                            Text(style.rawValue)
                        }
                    }
                    TextField("Beschreibung", text: $pinnwandViewModel.description)
                    // Falls Sie möchten, dass der Benutzer ein Datum auswählen kann:
                    Text("Veröffentlichungsdatum: \(pinnwandViewModel.publishedDate, formatter: itemFormatter)")
                    Text("Verfasser: \(pinnwandViewModel.publishedBy?.fullName ?? "Default Name")")
                }
                
                Section {
                    Button(action: {
                        pinnwandViewModel.savePinnwandPost()
                    }) {
                        Text("Post speichern")
                    }
                    .disabled(pinnwandViewModel.title.isEmpty || pinnwandViewModel.description.isEmpty)
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Abbrechen"){
                        dismiss()
                    }
                }
            }
            .navigationTitle("Neuer Pinnwand Beitrag")
            .alert(isPresented: $pinnwandViewModel.showAlert) {
                Alert(title: Text("Hinweis"), message: Text(pinnwandViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

//#Preview {
//    PinnwandAddView()
//}
