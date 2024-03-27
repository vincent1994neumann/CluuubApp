//
//  LetsGoRowingRequest.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import SwiftUI

struct LetsGoRowingRequestView: View {
    
    @ObservedObject var LGRViewModel : LetsGoRowingViewModel
    @State var distance = 10.0
    @State private var selectedRowerId: String? = nil
    
    @State private var searchText = ""
    @State private var showAlertNoAvailableSeats = false
    @State private var showPublishConfirmationAlert = false
    @State private var publishConfirmed = false
    
    
    @Environment(\.dismiss) private var dismiss
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Captain")){
                        HStack{
                            Text(LGRViewModel.publishedBy?.name ?? "error Username")
                            Text(LGRViewModel.publishedBy?.lastName ?? "error Userlastname")
                            Text(LGRViewModel.publishedBy?.age ?? "error Userlastage")
                        }
                    }
                    
                    Section(header: Text("Ruderanfrage")){
                        
                        Picker("Ruderstil", selection: $LGRViewModel.selectedRowingStyle){
                            ForEach(RowingStyle.allCases, id: \.self){ style in
                                Text(style.rawValue)
                            }
                        }
                        Picker("Bootsklasse", selection: $LGRViewModel.selectedBoatType){
                            ForEach(BoatType.allCases, id: \.self){ boat in
                                Text(boat.rawValue)
                            }
                        }
                        Picker("Ruderkompetenz", selection: $LGRViewModel.skillLevel){
                            ForEach(SkillLevel.allCases, id: \.self){ skill in
                                Text(skill.rawValue)
                            }
                        }
                    }
                    
                    Section(header: Text("Rudertermin")){
                        DatePicker("Rudertermin", selection: $LGRViewModel.rowingDate)
                        
                        HStack{
                            Slider(value: $LGRViewModel.distance, in: 0.0...30.0)
                            Text(LGRViewModel.distance, format: .number.precision(.fractionLength(1)))
                            Text("km")
                        }
                    }
                    
                    Section(header: Text("Liste von Ruderern")) {
                        HStack{
                            Spacer()
                            Button(LGRViewModel.isPublisherInBoat ? "Mich aus Boot entfernen" : "Mich zum Boot hinzufügen") {
                                LGRViewModel.togglePublisherInRowerList()
                            }
                            Spacer()
                        }
                        TextField("Ruderer manuell platzieren", text: $searchText)
                            .onChange(of: searchText) {old, new in
                                LGRViewModel.filterUsers(with: new)}
                        
                        
                        if !searchText.isEmpty {
                            ForEach(LGRViewModel.filterUsers, id: \.id) { filteredUser in
                                Button(action: {
                                    // Überprüfen Sie, ob noch Plätze verfügbar sind, bevor Sie den Ruderer hinzufügen
                                    if LGRViewModel.availableSeats > 0 {
                                        LGRViewModel.addRowerToRowerList(rower: filteredUser)
                                        searchText = "" // Suche zurücksetzen
                                        LGRViewModel.updateAvailableSeats()
                                    } else {
                                        // Keine verfügbaren Sitze, zeige Alert
                                        showAlertNoAvailableSeats = true
                                    }
                                }) {
                                    Text("\(filteredUser.name) \(filteredUser.lastName)")
                                }
                            }
                        }
                        
                        ForEach(0..<LGRViewModel.selectedBoatType.numberOfSeats, id: \.self) { index in
                            if index < LGRViewModel.rowerList.count {
                                // Zeige vorhandene Ruderer
                                let rower = LGRViewModel.rowerList[index]
                                HStack {
                                    Text(rower.name)
                                    Text(rower.lastName)
                                    Spacer()
                                    Button("Entfernen") {
                                        LGRViewModel.removeRowerFromRowerList(rower: rower)
                                    }
                                }
                            }  else {
                                // Zeige "Freier Sitz" und Hinzufügen-Button
                                HStack {
                                    Spacer()
                                    Text("Freier Sitz").italic().font(.footnote)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showAlertNoAvailableSeats) {
                        Alert(
                            title: Text("Keine freien Plätze"),
                            message: Text("Alle Plätze in diesem Boot sind bereits belegt. Sie können keine weiteren Ruderer hinzufügen."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    
                    Section(header: Text("Sonstige Informationen")){
                        TextEditor(text: $LGRViewModel.notes)
                            .frame(height: 100)
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button("Anfrage veröffentlichen"){
                            
                            showPublishConfirmationAlert = true
                        }
                        Spacer()
                    } .disabled(LGRViewModel.rowerList.isEmpty)
                        .alert(isPresented: $showPublishConfirmationAlert) {
                            Alert(
                                title: Text("Anfrage veröffentlichen"),
                                message: Text("Möchten Sie die Anfrage wirklich veröffentlichen?"),
                                primaryButton: .destructive(Text("Veröffentlichen")) {
                                    publishConfirmed = true
                                    LGRViewModel.saveRowerRequest()
                                    dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    
                }.toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Abbrechen"){
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    LetsGoRowingRequestView(LGRViewModel: LetsGoRowingViewModel())
}


