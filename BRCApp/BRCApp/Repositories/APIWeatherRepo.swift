//
//  APIWeatherRadarRepo.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 28.03.24.
//

import Foundation

class APIWeatherRepo{
    
    //52.418138, 13.171081)
    //https://api.openweathermap.org/data/2.5/weather?lat=52.41&lon=13.17&appid=d04b3899d712aa8320cc9c056018bd57
    private let APIKey : String = "d04b3899d712aa8320cc9c056018bd57"
    var lon : Double = 13.17
    var lat : Double = 52.41
    var baseURL : String {"https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIKey)"}
 
    
    func fetchWeather(completion: @escaping (WeatherResponse?) -> Void) {
          guard let url = URL(string: baseURL) else {
              print("Ungültige URL.")
              completion(nil)
              return
          }

          URLSession.shared.dataTask(with: url) { data, response, error in
              if let error = error {
                  print("Fehler beim Abrufen der Wetterdaten: \(error)")
                  completion(nil)
                  return
              }

              guard let data = data else {
                  print("Keine Daten erhalten.")
                  completion(nil)
                  return
              }

              do {
                  let decoder = JSONDecoder()
                  let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                  completion(weatherResponse)
              } catch {
                  print("Fehler beim Dekodieren der Antwort: \(error)")
                  completion(nil)
              }
          }.resume()
      }
  }


    

