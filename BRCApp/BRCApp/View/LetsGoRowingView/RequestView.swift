//
//  RequestView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 21.03.24.
//

import SwiftUI

struct RequestView: View {
    var request: LetsGoRowingRequest
    @ObservedObject var LGRViewModel : LetsGoRowingViewModel
       
    
  
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack{
                Spacer()
                Text("\(request.rowingDate, formatter: itemFormatter)")
                    .font(.subheadline)
                    .bold()
                Spacer()
            }
            
            HStack {
                Text("Ruderstil:")
                    .font(.subheadline)
                    .italic()
                Text("\(request.rowingStyle.rawValue)")
                    .font(.subheadline)
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Bootsklasse:")
                    .font(.subheadline)
                    .italic()
                
                Text("\(request.boatType.rawValue)")
                    .font(.subheadline)
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Fähigkeitsniveau:")
                    .font(.subheadline)
                    .italic()
                Text("\(request.skillLevel.rawValue)")
                    .font(.subheadline)
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.purple)
                Text("Verfügbare Sitze:")
                    .font(.subheadline)
                    .italic()
                Text("\(request.availableSeats)")
                    .font(.subheadline)
                    .bold()
                Spacer()
                
                if !request.requestClosed{
                    Button(action: {
                        LGRViewModel.toggleRowerInRequest(requestId: request.id ?? "Error ID")
                    }) {
                        VStack {
                            if LGRViewModel.isRowerInBoat(for: request.id ?? "Error ID") {
                                // Icon für "Platz aufgeben"
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                                Text("Platz aufgeben")
                            } else {
                                // Icon für "Platz einnehmen"
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text("Platz nehmen")
                            }
                        }
                    }

                }else{
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
        .background(request.skillLevel.skillColor.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(request.rowingStyle.strokeColor, lineWidth: 4)
        )
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
        .padding(.all,4)
        
        
    }
    
    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
