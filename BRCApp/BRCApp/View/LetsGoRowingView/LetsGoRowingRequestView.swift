//
//  LetsGoRowingRequest.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import SwiftUI

struct LetsGoRowingRequestView: View {
    
    @StateObject var LGRViewModel = LetsGoRowingViewModel()
    @State var distance = 10.0
    var body: some View {
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
                        Text(distance, format: .number.precision(.fractionLength(1)))
                        Text("km")
                    }
                }
                
                Section(header: Text("Liste von Ruderern")){
                    HStack{
                        Spacer()
                        Button(LGRViewModel.isPublisherInBoat ? "Aus Boot entfernen" : "Mich zum Boot hinzufügen") {
                            LGRViewModel.togglePublisherInRowerList()
                        }

                        Spacer()
                    }
                    
                    ForEach(0..<LGRViewModel.selectedBoatType.numberOfSeats, id: \.self) { index in
                        if index < LGRViewModel.rowerList.count, let rower = LGRViewModel.rowerList[index] {
                            HStack{
                                Text(rower.name)
                                Text(rower.lastName)
                                
                            }
                        } else {
                            HStack{
                                Text("Freier Sitz")
                                    .italic()
                                    .font(.footnote)
                            }
                               
                        }
                    }
                }
                
                Section(header: Text("Sonstige Informationen")){
                    TextEditor(text: $LGRViewModel.notes)
                        .frame(height: 100)
                }
                
                HStack{
                    Spacer()
                    Button("Anfrage veröffentlichen"){
                    }
                    Spacer()
                }
            }
        }
    }
}


//#Preview {
//    LetsGoRowingRequestView()
//}
