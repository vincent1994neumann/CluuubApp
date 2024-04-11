//
//  ClubInfoView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 18.03.24.
//

import SwiftUI
import MapKit

struct ClubInfoView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                
                Text("Über den Berliner Ruder-Club")
                    .font(.title3)
//                    .italic()
//                    .foregroundStyle(Color(.blue))
//                    .multilineTextAlignment(.leading)
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                
                Image("ClubHausFront")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(10)
                
                
                Text("Gegründet 1876, bietet der Berliner Ruder-Club (BRC) am malerischen Kleinen Wannsee sowohl Leistungs- als auch Breitensport.\nDas historische und zugleich moderne Clubhaus beherbergt eine Gemeinschaft von über 700 Mitgliedern mit einer aktiven Jugendabteilung.\nNeben dem Rudersport fördert der BRC auch Radsport und Laufsport im nahegelegenen Düppeler Forst.")
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .multilineTextAlignment(.center)

                
                Divider()
                    .padding(.bottom, 16)

                
                Image("4xHawkEye1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(10)
                
          
                
                Text("Der BRC legt Wert auf die körperliche Ertüchtigung und das Gemeinschaftsgefühl. Rudern ist eine Sportart für alle Altersklassen, die körperliche Fitness und Teamgeist gleichermaßen fördert. Die Clubmitglieder genießen Zugang zu einem Bootspark von etwa 115 Booten und beteiligen sich an Trainingseinheiten im Rennradfahren, Schwimmen und Laufen, was den Zusammenhalt stärkt.")
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .padding(.bottom, 16)
                
                                
                Image("ClubGemeinschaft")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(10)
                
                
                Text("Im BRC steht die Freude am Rudern und der Teamgeist im Vordergrund, egal ob man sich für Regatten oder das Freizeitrudern entscheidet. Der Club lebt von und für seine Mitglieder und deren Begeisterung für den Rudersport und darüber hinaus.")
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .padding(.bottom, 10)
                
                // Weitere Informationen können hier hinzugefügt werden
                Text("Impressum")
                    .font(.title3)
                    .padding()
                
                MapView()
                
                
                // Kontaktinformationen
                Text("Berliner Ruder-Club e.V.")
                    .font(.callout)
                    .padding(.bottom, 4)
                Text("Adresse: Bismarckstraße, 14109 Berlin")
                    .font(.caption)
                Text("Telefon: (030) 803 67 84")
                    .font(.caption )
                Text("E-Mail: kontakt@berliner-ruder-club.de")
                    .font(.caption)
                
                Text("Homepage: https://www.berliner-ruder-club.de")
                    .font(.caption)
            }
        }
        .navigationTitle("BRC")
        .padding()
    }
}

struct ClubInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ClubInfoView()
    }
}


