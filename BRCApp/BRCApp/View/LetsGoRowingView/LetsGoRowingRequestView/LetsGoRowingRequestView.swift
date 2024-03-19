//
//  LetsGoRowingRequest.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 16.03.24.
//

import SwiftUI

struct LetsGoRowingRequestView: View {
    
    @State private var selectedBoatType = BoatType.double
    @State private var selectedRowingStyle = RowingStyle.skull
    @State private var skillLevel = SkillLevel.beginner
    @State private var rowingDate = Date()
    @State private var distance = 10.0
    @State private var rowers: [String] = []
    @State private var notes = ""
    
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Ruderanfrage")){
                    
                    Picker("Ruderstil", selection: $selectedRowingStyle){
                        ForEach(RowingStyle.allCases, id: \.self){ style in
                            Text(style.rawValue)
                        }
                    }
                    Picker("Bootsklasse", selection: $selectedBoatType){
                        ForEach(BoatType.allCases, id: \.self){ boat in
                            Text(boat.rawValue)
                        }
                    }
                    Picker("Ruderkompetenz", selection: $skillLevel){
                        ForEach(SkillLevel.allCases, id: \.self){ skill in
                            Text(skill.rawValue)
                        }
                    }
                }
                
                Section(header: Text("Rudertermin")){
                    DatePicker("Rudertermin", selection: $rowingDate)
                    
                    HStack{
                        Slider(value: $distance, in: 0.0...30.0)
                        Text(distance, format: .number.precision(.fractionLength(1)))
                        Text("km")
                    }
                }
                
                Section(header: Text("free Seats")){
                    ForEach(0..<selectedBoatType.rowerList, id:  \.self){ index in
                        Text("Seat \(index + 1)")
                    }
                }
                
                Section(header: Text("Sonstige Informationen")){
                    TextEditor(text: $notes)
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

#Preview {
    LetsGoRowingRequestView()
}
