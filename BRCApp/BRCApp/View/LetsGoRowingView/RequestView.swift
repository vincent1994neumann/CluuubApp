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
        ZStack(alignment: .topTrailing) {
            
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
                        .foregroundStyle(Color(request.skillLevel.skillColor))
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
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            )
            .cornerRadius(10)
            .shadow(radius: 2)
            
            
            
            .background(Image("EinerSkull")
                .resizable()
                .scaledToFill()
                .opacity(0.1))
            
            VStack{
                NavigationLink(destination: RequestDetailView(request: request)) {
                    Image(systemName: "info.circle")
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
                .padding(.bottom,4)
                
                
                if !request.requestClosed{
                    Button(action: {
                        LGRViewModel.toggleRowerInRequest(requestId: request.id ?? "Error ID")
                    }) {
                        VStack {
                            if LGRViewModel.isRowerInBoat(for: request.id ?? "Error ID") {
                                
                                Text("Platz aufgeben")
                                    .foregroundStyle(.red)
                            } else {
                                // Icon für "Platz einnehmen"
                                Image("RuderblaetterCrossedUp")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                
                                Text("Platz nehmen")
                                    .foregroundStyle(.blue)
                                
                            }
                        }.padding(.all,2) // Etwas Abstand um den Text und das Bild
                            .frame(width: 80, height: 100)
                    }
                    
                }else{
                    
                }
            }.padding(.trailing, 16)
                .padding(.top, 16)
                
        }
        
    }
    
    
    
    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
